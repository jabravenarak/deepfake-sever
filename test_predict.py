import os

from predict_image import predict_image

frames_folder = "frames"

results = []

for file_name in os.listdir(frames_folder):

    if file_name.endswith(".jpg"):

        frame_path = os.path.join(frames_folder, file_name)

        result = predict_image(frame_path)

        print(file_name, result)

        results.append(result)


fake_count = sum(
    1 for r in results
    if r["label"].lower() == "artificial"
)

total_frames = len(results)

avg_confidence = sum(
    r["confidence"] for r in results
) / total_frames


video_result = {
    "label": "fake" if fake_count / total_frames > 0.4 else "real",
    "average_confidence": round(avg_confidence, 2),
    "fake_frames": fake_count,
    "total_frames": total_frames
}

print("\nFINAL RESULT:")
print(video_result)