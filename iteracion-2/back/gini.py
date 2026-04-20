import requests
from flask import jsonify

dominio = "https://api.worldbank.org"
path = "/v2/en/country/ARG/indicator/SI.POV.GINI"
uri = "?format=json&date=2011:2020&per_page=32500&page=1&country=%22Argentina%22"

def get_values_default():
    # Parámetros iniciales
    params = {
        "format": "json",
        "date": "2010:2020",
        "per_page": 32500, 
        "page": 1,
        "country": "Argentina"
    }
    
    return get_values (params)

def get_gini_date(date_start: str, date_end: str):
    params = {
        "format": "json",
        "date": f"{date_start}:{date_end}",
        "per_page": 32500, 
        "page": 1,
        "country": "Argentina"
    }

    return get_values (params)

def get_values (params):
    
    all_results = []
    has_more_pages = True

    try:
        while has_more_pages:
            response = requests.get(f"{dominio}{path}", params=params)
            response.raise_for_status()
            data = response.json()

            # La API del BM devuelve una lista: [metadatos, datos]
            metadata = data[0]
            values = data[1]

            if values:
                all_results.extend(values)

            # Verificamos si la página actual es la última
            if params["page"] >= metadata["pages"]:
                has_more_pages = False
            else:
                params["page"] += 1  # Incrementamos para la siguiente vuelta

        return {
            "count": len(all_results),
            "data": all_results
        }

    except requests.exceptions.RequestException as e:
        return {
            "count": 0,
            "data": []
        }
