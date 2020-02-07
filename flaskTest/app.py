import os
from flask import Flask, flash, redirect, url_for, render_template, request, send_file
app = Flask(__name__)

app.config["UPLOAD_FOLDER"] = "./uploads"
@app.route('/')
def hello():
    return render_template("/index.html")
    
@app.route("/upload", methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        if request.files:
            file = request.files["file"]
            if file.filename == "":
                return render_template("upload.html")
            file.save(os.path.join(app.config["UPLOAD_FOLDER"], file.filename))
            #uploadedFiles.append(file.filename)
            return render_template("successupload.html")
    else:
        return render_template("/upload.html")

@app.route("/download")
def download():
    uploadedFiles = [f for f in os.listdir("./uploads/")]
    return render_template("/download.html", content=uploadedFiles)

def downloadThis(filename):
    path = "/uploads/"+filename
    send_file(path, as_attachment=True)
    return

@app.route("/aboutUs")
def aboutUs():
    return render_template("/aboutUs.html")

@app.route("/contactUs")
def contactUs():
    return render_template("/contactUs.html")
        
if __name__ == "__main__":
    app.run(host = '0.0.0.0', port = 5001, debug = True)
