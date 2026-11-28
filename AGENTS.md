# Contexte projet
Environnement Docker local (Odoo 17 + PostgreSQL 15 via Docker Compose) pour tester des addons Odoo, surtout `odoo-yavin` ; pas d'application ni de code propre ici.

## Commandes de vérification
- Test ciblé : aucun
- Suite complète : aucun
- Lint / format : `docker compose -f 17.0/docker-compose.yml config -q` (validation du compose)
- Typecheck : aucun

## Règles
- Si le besoin ou un cas limite est ambigu, poser 2 ou 3 questions courtes avant de coder. Sinon, exécuter directement.
- Ne toucher qu'aux fichiers nécessaires. Pas de nouvelle dépendance sans demander.
- Ne jamais lire, afficher ni committer de secrets ou de fichiers `.env`.

## Pièges et décisions non évidentes
- Tout vit dans `17.0/` (un dossier par version d'Odoo) : lancer `docker compose` depuis ce dossier.
- `17.0/addons/*` est ignoré par git : les addons y sont clonés à part (branche `17.0`), jamais committés ici.
- Le compose ne monte que `addons/odoo-yavin` : un autre addon demande un volume dans `docker-compose.yml` en plus de l'`addons_path` d'`odoo.conf`.
- Les identifiants `odoo`/`odoo` du compose sont ceux d'un environnement de test local, à ne pas réutiliser ailleurs.

## Définition de fini
`docker compose config -q` sans erreur, aucun changement hors sujet.
