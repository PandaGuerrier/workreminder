# Work Reminder Bot

Bot Discord qui envoie "@everyone travaillez !" tous les jours à 17h dans un channel configuré.

---

## 🚀 Getting Started

### 1. Configuration

1. Copiez le fichier `.env.exemple` vers `.env`
2. Remplissez les champs requis:
   - `TOKEN`: Votre token Discord
   - `CHANNEL_ID`: L'ID du channel où envoyer les rappels

### 2. Install Dependencies

Assurez-vous d'avoir [Dart](https://dart.dev/get-dart) installé.

```bash
dart pub get
```

### 3. Lancer le bot

```bash
dart bin/main.dart
```

Le bot enverra automatiquement "@everyone travaillez !" tous les jours à 17h00 dans le channel configuré.

## Configuration

| Variable | Description |
|----------|-------------|
| `TOKEN` | Token de votre bot Discord |
| `CHANNEL_ID` | ID du channel de destination |

## 🐳 Docker / Dokploy

Le Dockerfile doit être construit depuis la racine du projet mineral:

```bash
# Depuis la racine du projet mineral
docker build -f exemples/workreminder/Dockerfile -t workreminder .
docker run -e TOKEN=your_token -e CHANNEL_ID=your_channel_id workreminder
```

### Déploiement Dokploy

1. Dans Dokploy, créez une nouvelle application
2. Configurez le build:
   - **Dockerfile Path**: `exemples/workreminder/Dockerfile`
   - **Context**: `.` (racine du repo)
3. Ajoutez les variables d'environnement:
   - `TOKEN`
   - `CHANNEL_ID`
# workreminder
