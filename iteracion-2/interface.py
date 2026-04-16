"""
 interfaz que muestre el índice GINI. 

 La capa superior recuperará la información del banco mundial https://api.worldbank.org/v2/en/country/all/indicator/SI.POV.GINI?format=json&date=2011:2020&per_page=32500&page=1&country=%22Argentina%22. 
 Se recomienda el uso de API Rest y Python. 

 Luego el programa en C o python mostrará los datos obtenidos.-
"""
from flask import Flask, jsonify, url_for

app = Flask(__name__)

#### Routes

@app.route("/values/plusone/<date_start>/<date_end>")
def get_from_date(date_start, date_end):
    from back.gini import get_gini_date     
    from back.middleware import middleware   
    
    items = get_gini_date(date_start, date_end)
    
    new_data = []
    for item in items.get("data", []):
        #date = item.get("date", "")
        value = item.get("value", -1)

        print (f"por enviar {value}")
        if (value != -1) and value is not None:
            value = middleware(value)
            item["value"] = value
            new_data.append(item)
    
    items["data"] = new_data
    return items

@app.route("/values/default")
def get_from_default():
    from back.gini import get_values_default    

    return get_values_default()

@app.route('/')
def site_map():
    """Ruta para listar todos los paths de la app en formato HTML."""
    routes = []
    for rule in app.url_map.iter_rules():
        # Saltamos la ruta de archivos estáticos para limpiar la vista
        if "static" not in rule.endpoint:
            routes.append({
                "endpoint": rule.endpoint,
                "methods": list(rule.methods),
                "path": str(rule)
            })
    
    # Generamos una tabla HTML simple
    html = """
    <h1>Rutas Registradas</h1>
    <table border="1" style="border-collapse: collapse; width: 80%; text-align: left;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th style="padding: 10px;">Endpoint</th>
                <th style="padding: 10px;">Métodos</th>
                <th style="padding: 10px;">Path</th>
            </tr>
        </thead>
        <tbody>
    """
    for r in routes:
        html += f"""
            <tr>
                <td style="padding: 10px;">{r['endpoint']}</td>
                <td style="padding: 10px;">{', '.join(r['methods'])}</td>
                <td style="padding: 10px;"><a href="{r['path']}">{r['path']}</a></td>
            </tr>
        """
    html += "</tbody></table>"
    
    return html
if __name__ == "__main__":
    app.run(debug=True)