# Grammix AI – AI-Powered Grammar Checker

Grammix AI is an AI-powered grammar checking application designed to help users improve the accuracy, clarity, and quality of their written English.

The application allows users to enter text directly or upload a `.txt` file. The submitted text is analyzed using a Large Language Model (LLM), which identifies grammatical and language-related issues and generates a corrected version while preserving the original meaning.

## Features

* AI-powered grammar correction
* Spelling mistake detection and correction
* Sentence structure improvement
* Punctuation correction
* Context-aware text correction
* Direct text input
* `.txt` file upload
* Corrected text output
* Download corrected text as a `.txt` file
* Simple and user-friendly interface
* LLM-based natural language processing

## Technologies Used

* **Flutter** – Application development and user interface
* **Dart** – Programming language
* **Large Language Model (LLM)** – Grammar analysis and correction
* **File Picker** – Text file selection and upload
* **Git & GitHub** – Version control and source-code management
* **Vercel** – Web deployment

## Project Architecture

The general workflow of Grammix AI is:

```text
User
  │
  ├── Enter Text
  │
  └── Upload .txt File
          │
          ▼
     Grammix AI
          │
          ▼
      LLM API
          │
          ▼
   Grammar Analysis
          │
          ▼
    Corrected Text
          │
          ├── Display
          │
          └── Download
```

## Requirements

Before running Grammix AI, make sure you have:

* Flutter SDK
* Dart SDK
* Git
* VS Code or Android Studio
* Internet connection
* A valid LLM API key

Check your Flutter installation:

```bash
flutter doctor
```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/afshansif/Grammix_AI_Grammer_Checker.git
```

Navigate to the project:

```bash
cd Grammix_AI_Grammer_Checker
```

### 2. Install Dependencies

Run:

```bash
flutter pub get
```

### 3. Configure the API Key

Grammix AI requires an API key to communicate with the LLM service.

**Never commit your API key to GitHub.**

Store the API key using the configuration method implemented in the project.

For example:

```text
API_KEY=your_api_key_here
```

Replace `your_api_key_here` with your actual API key.

Make sure sensitive configuration files are included in `.gitignore`:

```gitignore
.env
*.env
secrets.dart
```

> Replace this section with the exact API provider and configuration method used by the application.

## Running the Application

Run the application locally with:

```bash
flutter run
```

To check available devices:

```bash
flutter devices
```

For Chrome/Web:

```bash
flutter run -d chrome
```

## Building the Web Application

To create a production web build:

```bash
flutter build web
```

The generated web application will be located in:

```text
build/web/
```

The main entry point is:

```text
build/web/index.html
```

## Example Input

```text
Artificial intelligence are becoming very important in our daily life.
It help people to complete difficult task quickly.
People should not depends completely on AI because it can provide
incorrect informations.
```

## Example Output

```text
Artificial intelligence is becoming very important in our daily lives.
It helps people complete difficult tasks quickly.
People should not depend completely on AI because it can provide
incorrect information.
```

## How the LLM Is Used

The Large Language Model is the main component responsible for understanding and correcting the user's text.

When the user submits text, Grammix AI sends the text to the LLM together with instructions to identify grammar, spelling, punctuation, and sentence-structure problems.

A simplified workflow is:

```text
User Text
    ↓
Application
    ↓
LLM API Request
    ↓
Language Analysis
    ↓
Grammar Correction
    ↓
Corrected Text
    ↓
Application Display
```

The LLM is provided with instructions similar to:

```text
You are an English grammar correction assistant.

Correct the following text for:
- Grammar
- Spelling
- Punctuation
- Sentence structure
- Incorrect word usage

Preserve the original meaning of the text.

Return the corrected version.

Text:
[USER TEXT]
```

Using an LLM allows Grammix AI to consider the context of a sentence instead of relying only on fixed grammar rules.

## Security

API keys and other sensitive credentials must not be committed to the GitHub repository.

Before pushing code, check that the project does not contain:

* API keys
* Passwords
* Access tokens
* `.env` files
* Private credentials
* Service-account files

If an API key is accidentally pushed to GitHub, immediately revoke or rotate the key.

## Future Improvements

Potential future improvements include:

* Detailed explanations for grammar mistakes
* Highlighting incorrect words
* Multiple correction suggestions
* Writing-style improvement
* Formal and informal writing modes
* Vocabulary improvement
* Grammar scoring
* Error categorization
* PDF and DOCX support
* Multiple language support
* Grammar correction history
* User accounts
* Saved documents
* Voice-to-text support

## Project Repository

GitHub:

https://github.com/afshansif/Grammix_AI_Grammer_Checker

## Author

**Afshan Sif**

GitHub:

https://github.com/afshansif

## License

This project is intended for educational and development purposes.

If the project is released as open source, an appropriate open-source license such as the MIT License can be added to the repository.
