from transformers import AutoModelForImageClassification
from transformers import AutoImageProcessor
from PIL import Image
import torch
import gradio as gr

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

# UI
demo = gr.Interface(
    fn=predict,
    inputs=gr.Image(),
    outputs=gr.JSON(),
    title="Deepfake Detector",
    description="Upload image to detect fake or real"
)

demo.launch()