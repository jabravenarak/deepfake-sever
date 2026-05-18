from transformers import AutoModelForImageClassification
from transformers import AutoImageProcessor
from PIL import Image
import torch
import gradio as gr

model = AutoModelForImageClassification.from_pretrained("./")
processor = AutoImageProcessor.from_pretrained("./")

labels = ["fake", "real"]

def predict(image):
    image = Image.fromarray(image)

    inputs = processor(images=image, return_tensors="pt")

    with torch.no_grad():
        outputs = model(**inputs)

    probs = torch.nn.functional.softmax(outputs.logits, dim=-1)

    pred = probs.argmax().item()
    confidence = probs[0][pred].item()

    return {
        "label": labels[pred],
        "confidence": round(confidence * 100, 2)
    }

demo = gr.Interface(
    fn=predict,
    inputs=gr.Image(),
    outputs=gr.JSON()
)

demo.launch()