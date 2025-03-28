!pip install skl2onnx onnxruntime

import onnx
import onnxruntime
import skl2onnx

print("ONNX Version:", onnx.__version__)
print("ONNX Runtime Version:", onnxruntime.__version__)
print("SKL2ONNX Version:", skl2onnx.__version__) # Corrected attribute

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score

# Load dataset
from sklearn.datasets import load_iris

data = load_iris()
df = pd.DataFrame(data.data, columns=data.feature_names)
df['target'] = data.target

# Split data into training and test set
X = df.drop('target', axis=1)
y = df['target']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Standardizing the features for better model performance
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Train Logistic Regression model
model = LogisticRegression(max_iter=200)
model.fit(X_train_scaled, y_train)

# Predictions
y_pred = model.predict(X_test_scaled)

# Evaluate model performance
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))
print("Accuracy:", accuracy_score(y_test, y_pred))

# Plot Confusion Matrix
plt.figure(figsize=(6,4))  # Adjusted figure size
sns.heatmap(confusion_matrix(y_test, y_pred), annot=True, fmt="d", cmap="Blues")
plt.xlabel('Predicted Label')
plt.ylabel('True Label')
plt.title('Confusion Matrix')
plt.xlabel('Predicted')
plt.ylabel('Actual')
plt.title('Confusion Matrix')
plt.show()  # Important to display the plot

import skl2onnx
from skl2onnx import convert_sklearn
from skl2onnx.common.data_types import FloatTensorType
import onnxruntime as ort

initial_type = [('float_input', FloatTensorType([None, X_train.shape[1]]))]
# Convert the trained model to ONNX format for interoperability across different platforms and frameworks
onnx_model = convert_sklearn(model, initial_types=initial_type)

# Save the model in ONNX format for interoperability across different platforms
with open("model.onnx", "wb") as f:
    f.write(onnx_model.SerializeToString())

session = ort.InferenceSession("model.onnx")
input_name = session.get_inputs()[0].name
pred_on_onnx = session.run(None, {input_name: X_test_scaled.astype('float32')})

# Print only the predicted labels for clarity
print("ONNX Model Predictions:", np.argmax(pred_on_onnx[0], axis=1) if len(pred_on_onnx[0].shape) > 1 else pred_on_onnx[0].astype(int))