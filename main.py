from fastapi import FastAPI
import pymysql

app = FastAPI()

# Connect to MySQL Database
db = pymysql.connect(host="localhost", user="root", password="1234567890", database="clinicbookingdb")
cursor = db.cursor()

# 🏥 Fetch all patients
@app.get("/patients")
def get_patients():
    cursor.execute("SELECT * FROM Patient")
    return cursor.fetchall()

# ➕ Add a new patient
@app.post("/patients")
def add_patient(name: str, email: str, phone: str):
    cursor.execute("INSERT INTO Patient (name, email, phone) VALUES (%s, %s, %s)", (name, email, phone))
    db.commit()
    return {"message": "Patient added successfully"}

# ✏️ Update patient details
@app.put("/patients/{patient_id}")
def update_patient(patient_id: int, phone: str):
    cursor.execute("UPDATE Patient SET phone = %s WHERE patient_id = %s", (phone, patient_id))
    db.commit()
    return {"message": "Patient updated"}

# 🗑️ Delete a patient record
@app.delete("/patients/{patient_id}")
def delete_patient(patient_id: int):
    cursor.execute("DELETE FROM Patient WHERE patient_id = %s", (patient_id,))
    db.commit()
    return {"message": "Patient removed"}
