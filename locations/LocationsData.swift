var locationsString = """
{ "locations": [
    {
        "lat": "19.327366",
        "lng": "-99.182957",
        "title": "La Pape",
        "subtitle": "Papelería local",
        "imagePath": "taco"
    },
    {
        "lat": "19.327966",
        "lng": "-99.183037",
        "title": "Bicipuma",
        "subtitle": "Anexo de ingeniería",
        "imagePath": "taco"
    }
]}
"""
let locationsData = locationsString.data(using: .utf8)!
