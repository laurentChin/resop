# Fonctionnalités

## *ResOp* en quelques points

**Partie Utilisateur**

- Chaque utilisateur crée un profil détaillé avec ses spécificités et ses compétences
- Chaque semaine, l'utilisateur met à jour ses disponibilités et peut consulter les missions sur lesquels il est engagé

**Partie Administrateurs**

- Les cadres des structures mettent à jour les fiches et disponibilités des ressources mobilisables (véhicules, ...)
- Les administrateurs accèdent à un planning répertoriant les disponibilités de chaque resource, peuvent les trier, les classer et faire des recherches
- Les resources disponibles peuvent être marquées comme "engagées" sur une mission sur la plage horaire correspondante
- Il est possible de réaliser des projections automatiques en fonction des caractéristiques des engagements à prendre
  (ressources nécessaires, compétences requises) et des disponibilités des ressources

## Démonstration

Un serveur de démonstration est disponible à l'adresse [https://resop.aws.mroca.fr/](https://resop.aws.mroca.fr/).

## Espace bénévole

Vous pouvez tester la partie utilisateur avec les identifiants suivants :

* Email :`user1@resop.com`
* Date de naissance: `01/01/1990`

Chaque bénévole peut :

- S'inscrire
- Modifier son profil
- Renseigner ses disponibilités pour la semaine courante
- Renseigner ses disponibilités pour la semaine prochaine

### Connexion

![Login](https://raw.githubusercontent.com/crf-devs/resop/master/docs/img/login.png)

### Mon compte bénévole

![Account](https://raw.githubusercontent.com/crf-devs/resop/master/docs/img/edit-account.png)

### Mes disponibilités

![Disponibilités](https://raw.githubusercontent.com/crf-devs/resop/master/docs/img/define-availability.png)

----

# Espace structure

## Structure locale

Chaque `structure` (une Unité Locale, par exemple) peut :

- Consulter la liste de ses bénévoles inscrits
- Consulter leurs disponibilités
- Ajouter ses véhicules
- Définir les disponibilités de ses véhicules

Identifiants de démo :

* structure: `UL09`
* mot de passe: `covid19`

### Planning

![Disponibilité des bénévoles](https://raw.githubusercontent.com/crf-devs/resop/master/docs/img/planning.png)

### Liste des bénévoles

![Liste des bénévoles](https://raw.githubusercontent.com/crf-devs/resop/master/docs/img/users-list.png)

### Liste des véhicules

![Liste des véhicules](https://raw.githubusercontent.com/crf-devs/resop/master/docs/img/assets-list.png)


## Structure parente

Les `structure parentes` (une Direction Territoriale, par exemple) peut :

- Effectuer les mêmes actions qu'une structure locale pour ses propres ressources
- Consulter et modifier ses structures locales
- Consulter et modifier les disponibilités de tous les véhicules et bénévoles

Identifiants de démo :

* structure: `DT75`
* mot de passe: `covid19`
