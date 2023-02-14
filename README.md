# Preview
![](https://github.com/KevinHern/background-generator-tfjs/blob/main/misc/background.png)

![](https://github.com/KevinHern/background-generator-tfjs/blob/main/misc/form_preview.png)

# Description
This is a project that combines app development and AI to make a small and simple yet charming demonstration so people can try it as they please.

It consists of using AI to create backgrounds with random patterns that people can modify or explore. People can choose the degree of complexity of the background, the primary color and the pattern they want.

# Technical Details

## Artificial Intelligence
Tensorflow was the tool used to develop an artificial intelligence. The reasons why it was selected are as follow:
- Easy to use and understand
- Compatibility with Javascript
- Models can be exported to Javascript
- Adaptability to production environments

## Web App
For the user interface, Flutter was used to develop a small web app that could handle the user's inputs and logic. The reasons why it was selected are as follow:
- Easy to use and understand
- Developing doesn't take too much time
- Can produce a web app and the files can be transported anywhere

## Backend
As for the backend's logic, NodeJS was selected for the following reasons:
- Easy to use and understand
- Supports serving web apps such as Flutter's web apps
- Uses Javascript and has compatibility with Tensorflow JS
- Can handle multiple requests at once without struggling

## Software
The following software were used to make this project:

**Artificial Intelligence**:
- Tensorflow (Python)
- Tensorflow JS

**Web App**:
- Flutter

**Backend**:
- Node JS
- Express JS

**Hosting**:
- Firebase Hosting

# Inspiration
The project's inspiration came from messing around with images using Tensorflow. The main idea was: **"what can AI generate if it is given pixel coordinates and then convert the output into an image?"**
Certainly, the results were very interesting and fun to mess around. The project came into existence after creating [this](https://colab.research.google.com/drive/1mfrLU2CGYoiEX1pqIJ2Dmi2rVn7ypV0z?usp=sharing) google colab notebook.

One of the Future Improvements was converting that Google Colab Notebook into something friendly that users could interact anywhere at anytime; basically, an application.

# Directory Structure
- flutter_frontend:
This directory contains the source code of the frontend made in flutter. The source code is located under **/lib/** and the directory structure inside of it follows the [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).
- nodejs-server:
This directory contains the source code of the backend with an already pre-built frontend.
    - The pre-built app is under **/public-flutter/** directory.
    - The AI script is under **/src/** directory.
    - The internal Routing and app declaration are under the **/app/** directory.
- misc:
This directory just contains images used for illustrative purposes.

To initialize the project, execute the following command inside the **/nodejs-server/** directory:

```bat
npm install
```

The entry point is **index.js**:

```bat
node index.js
```

Access the web app locally by openning a browser and accessing the following address:

```bat
http://127.0.0.1:16000/
```

# References
Here are some useful links used to make this project a reality.

**NodeJS related**:
- [NodeJS Folder Structure - Dev.to](https://dev.to/mr_ali3n/folder-structure-for-nodejs-expressjs-project-435l)
- [NodeJS Router - Blueeweb](https://bluuweb.github.io/node/04-router/#mascotas-router)
- [NodeJS Routing - Tutorialspoint](https://www.tutorialspoint.com/expressjs/expressjs_routing.htm)
- [Deploy AI using NodeJS - GitHub](https://github.com/KevinHern/AI-Deployment-NodeJS)

**Flutter Related**:
- [Run a Flutter web app and API on NodeJS - LogRocket](https://blog.logrocket.com/flutter-web-app-node-js/)

**UI Related**:
- [Material 3 Theme Builder - Material.io](https://m3.material.io/theme-builder#/custom)
- [Palette Generator - Coolors](https://coolors.co/generate)
- [Font Combiner - FontJoy](https://fontjoy.com)

**Hosting Related**:
-