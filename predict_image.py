from transformers import AutoModelForImageClassification
from transformers import ViTImageProcessor
from PIL import Image
import torch

MODEL_NAME = "Jabrave/deepfake-detector"

model = AutoModelForImageClassification.from_pretrained(MODEL_NAME)

processor = ViTImageProcessor.from_pretrained(MODEL_NAME)

model.eval()


def predict_image(image_path):
    image = Image.open(image_path).convert("RGB")

    inputs = processor(images=image, return_tensors="pt")

    with torch.no_grad():
        outputs = model(**inputs)

    probs = torch.softmax(outputs.logits, dim=1)

    confidence, predicted_class = torch.max(probs, dim=1)

    label = model.config.id2label[predicted_class.item()]

    return {
        "label": label,
        "confidence": round(confidence.item() * 100, 2)
    }