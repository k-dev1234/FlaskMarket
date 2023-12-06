from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
@app.route("/home")
def hello_world():
    return render_template("home.html")


@app.route("/about")
def about_page():
    return render_template("about.html")

#adding commentss
if __name__  == "__main__":
    app.run(host="0.0.0.0", port=int("80"), debug=True)
