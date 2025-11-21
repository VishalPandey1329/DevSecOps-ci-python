from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({"message": "Hello from DevSecOps demo app!"})

# Simple CRUD-like in-memory example
ITEMS = []

@app.route('/items', methods=['GET'])
def list_items():
    return jsonify(ITEMS)

@app.route('/items', methods=['POST'])
def add_item():
    data = request.get_json() or {}
    item = {"id": len(ITEMS)+1, "name": data.get("name", "unnamed")}
    ITEMS.append(item)
    return jsonify(item), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
