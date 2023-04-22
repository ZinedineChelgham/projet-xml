import xml.etree.ElementTree as ET


# Charger le fichier XML
tree = ET.parse('agence_sejour_linguistique_bd.xml')
root = tree.getroot()

# Parcourir tous les éléments de la base de données
def display_all(root, bd_origin):
    print("------------------Affichage de la bd %s (%d offres disponibles)------------------" % (bd_origin, len(root.findall('.//offre'))))
    for offre in root.findall('.//offre'):
        type_offre = offre.get('type')
        langue = offre.find(".//langue").text
        destination = offre.find(".//ville").text + ', ' + offre.find(".//pays").text
        activites_sportives = offre.find(".//activites_sportives")
        activites_sportives = activites_sportives.findall(".//activites_sportive")
        activites_sportives = [activite.text for activite in activites_sportives]
        activites_culturelles = offre.find(".//activites_culturelles")
        activites_culturelles = activites_culturelles.findall(".//activites_culturelle")
        activites_culturelles = [activite.text for activite in activites_culturelles]

        date = offre.find(".//dates")
        date_debut = date.find("debut").text
        date_fin = date.find("fin").text

        client_type = offre.find(".//client").get('type')
        nom_client = offre.find(".//client/nom").text
        prenom_client = offre.find(".//client/prenom").text
        age_client = offre.find(".//client/age").text

        print("Type d'offre : ", type_offre)
        print("Langue : ", langue)
        print("Destination : ", destination)
        print("Activités sportives : ", activites_sportives)
        print("Activités culturelles : ", activites_culturelles)
        print("Date debut : ", date_debut)
        print("Date fin : ", date_fin)
        print("Type de client : ", client_type)
        print("Nom du client : ", nom_client)
        print("Prénom du client : ", prenom_client)
        print("Âge du client : ", age_client)
        print("--------------")

display_all(root, "orignale")


# Récupération des offres d'un client donné
def get_offres_client(nom, prenom):
    offres = []
    for offre in root.findall('.//offre'):
        nom_client = offre.find(".//client/nom").text
        prenom_client = offre.find(".//client/prenom").text
        if nom_client.lower() == nom.lower() and prenom_client.lower() == prenom.lower():
            offres.append(offre)
    return offres

# Récupération des offres d'un client donné
print("------------------Affichage des offres d'un client donné (DUPONT Paul)------------------")
offres = get_offres_client("DUPONT", "Paul")
for offre in offres:
    print(ET.tostring(offre, encoding='unicode'))



#Suppression de toutes les offres d'un client donné et génération d'un nouveau fichier XML
def delete_offres_client(nom, prenom):
    offres = get_offres_client(nom, prenom)
    for offre in offres:
        root.remove(offre)
    tree.write('./script_out/agence_sejour_linguistique_bd_scripted.xml')

delete_offres_client("DUPONT", "Paul")
# Charger le fichier XML
tree = ET.parse('./script_out/agence_sejour_linguistique_bd_scripted.xml')
root = tree.getroot()
display_all(root, "modifiée")


