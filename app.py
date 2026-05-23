from transformers import AutoModelForImageClassification
from transformers import AutoImageProcessor
from PIL import Image
import torch
import gradio as gr
from extract_frames import extract_frames
from predict_image import predict_image

import os
import shutil

# โหลดโมเดล
model = AutoModelForImageClassification.from_pretrained(
    "Jabrave/deepfake-detector"
)

processor = AutoImageProcessor.from_pretrained(
    "Jabrave/deepfake-detector"
)

# โหลด labels จาก config อัตโนมัติ
id2label = model.config.id2label

print("Loaded labels:", id2label)

def predict(image):

    # แปลงเป็น PIL Image
    image = Image.fromarray(image)

    # preprocess
    inputs = processor(images=image, return_tensors="pt")

    # inference
    with torch.no_grad():
        outputs = model(**inputs)

    # softmax
    probs = torch.nn.functional.softmax(outputs.logits, dim=-1)

    # class ที่มั่นใจสุด
    pred = probs.argmax().item()

    # confidence
    confidence = probs[0][pred].item()

    # label จริงจาก model
    label = id2label[pred]

    return {
        "label": label,
        "confidence": round(confidence * 100, 2)
    }

def predict_video(video_path):

    # extract frames
    extract_frames(video_path)

    results = []

    for file_name in os.listdir("frames"):

        if file_name.endswith(".jpg"):

            frame_path = os.path.join("frames", file_name)

            result = predict_image(frame_path)

            results.append(result)

    FAKE_LABELS = [
        "fake",
        "artificial",
        "generated",
        "deepfake"
    ]

    fake_count = sum(
        1 for r in results
        if r["label"].lower() in FAKE_LABELS
    )

    total_frames = len(results)

    avg_confidence = sum(
        r["confidence"] for r in results
    ) / total_frames

    final_result = {
        "label": "fake" if fake_count / total_frames > 0.4 else "real",
        "average_confidence": round(avg_confidence, 2),
        "fake_frames": fake_count,
        "total_frames": total_frames
    }

    return final_result

# UI
image_ui = gr.Interface(
    fn=predict,
    inputs=gr.Image(),
    outputs=gr.JSON(),
    title="Image Deepfake Detector"
)

video_ui = gr.Interface(
    fn=predict_video,
    inputs=gr.Video(),
    outputs=gr.JSON(),
    title="Video Deepfake Detector"
)

demo = gr.TabbedInterface(
    [image_ui, video_ui],
    ["Image", "Video"]
)

demo.launch()