# 📱 FocusFlow

## 🧠 Descripción

**FocusFlow** es una app de productividad diseñada para reducir la fricción mental y ayudar a convertir tareas grandes en acciones pequeñas y ejecutables.

A diferencia de un to-do tradicional, la app no muestra listas interminables, sino que guía al usuario paso a paso:

> “¿Qué tengo que hacer ahora mismo?”

---

## 🚀 Idea principal

- ❌ No listas complejas
- ❌ No sobrecarga de decisiones
- ❌ No multitarea constante

✔ Solo una acción visible  
✔ Solo el siguiente paso importa  
✔ Flujo continuo de acción guiada

---

## ⚙️ Stack tecnológico

- Flutter
- Riverpod (state management)
- Firebase Auth (Google OAuth)
- Firestore (base de datos principal)
- go_router
- Arquitectura feature-first + clean architecture ligera

---

# 🧱 Arquitectura del proyecto

El proyecto está organizado con un enfoque **feature-first escalable**, separando claramente lógica de negocio, infraestructura y UI.

---

## 📦 Estructura general
lib/
-
├── core/
-
├── features/
-
├── shared/
-
└── main.dart
-

---

# 🧠 CORE (infraestructura global)

Contiene toda la base técnica del proyecto.
-
core/
-
├── app/
-
│ ├── app_initializer.dart
-
│ ├── session_controller.dart
-
│
├── firebase/
-
│ ├── firebase_options.dart
-
│ ├── firebase_init.dart
-
│
├── auth/
-
│ ├── auth_service.dart
-
│ ├── auth_repository.dart
-
│ ├── user_provider.dart
-
│
├── firestore/
-
│ ├── firestore_client.dart
-
│ ├── collections.dart
-
│
├── cache/
-
│ ├── local_storage_service.dart
-
│
├── router/
-
│ ├── app_router.dart
-
│
├── theme/
-
│ ├── app_theme.dart
-
│
├── utils/
-
│ ├── date_utils.dart
-
│ ├── id_generator.dart
-


---

# 🧩 FEATURES (módulos de la app)

Cada feature es independiente y escalable.
------------
features/
├── auth/
├── tasks/
├── focus/
├── routines/
├── widget/
├── ai/
├── premium/
-------------

---

## 🔐 AUTH (autenticación)
auth/
├── data/
├── domain/
├── presentation/


✔ Login con Google OAuth  
✔ Gestión de usuario global

---

## 🧱 TASKS (núcleo de la app)

Sistema principal de tareas y acción actual.


tasks/
├── data/
│ ├── models/
│ ├── datasources/
│ ├── repositories/
│
├── domain/
│ ├── entities/
│ ├── repositories/
│ ├── usecases/
│ │ ├── add_task.dart
│ │ ├── complete_task.dart
│ │ ├── get_next_task.dart
│
├── presentation/
│ ├── controllers/
│ ├── screens/
│ ├── widgets/


---

## 🧠 FOCUS (experiencia diferencial)


focus/
├── data/
├── domain/
├── presentation/


✔ Modo concentración  
✔ Botón “Empezar”  
✔ Temporizador simple  
✔ Una sola acción visible

---

## 🔁 ROUTINES (automatización)


routines/
├── data/
├── domain/
├── presentation/


✔ Secuencias de acciones  
✔ Rutinas tipo “mañana”, “estudio”, etc.

---

## 📱 WIDGET


widget/
├── presentation/


✔ Tarea actual  
✔ Botón iniciar foco  
✔ Acceso rápido a rutinas

---

## 🤖 AI (diferenciador)


ai/
├── data/
├── domain/
├── presentation/


✔ Convierte tareas grandes en microacciones  
✔ Ejemplo: “Estudiar examen” → pasos de 1–3 min

---

## 💰 PREMIUM


premium/
├── data/
├── domain/
├── presentation/


✔ Suscripción  
✔ Límites IA  
✔ Features avanzadas

---

# 🔄 Flujo de arquitectura


UI
↓
Controller (Riverpod)
↓
UseCase
↓
Repository
↓
DataSource
↓
Firebase


---

# ☁️ Firestore structure


users/
{uid}/
tasks/
routines/
sessions/
settings/


---

# 🧠 Principios del proyecto

- Firebase solo es infraestructura
- La app siempre responde: “¿qué hago ahora?”
- Solo una acción visible en pantalla
- El sistema reduce decisiones, no las aumenta
- Preparado para IA desde la base

---

# 🚀 Estado del proyecto

✔ Arquitectura definida  
✔ Firebase integrado  
✔ Escalable a IA y automatización  
⏳ En desarrollo MVP  