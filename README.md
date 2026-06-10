# 📱 FocusFlow

## 🧠 Descripción

**FocusFlow** es una aplicación de productividad especializada para personas con **TDAH (Trastorno por Déficit de Atención e Hiperactividad)**. Su objetivo principal es mitigar la parálisis por análisis y la disfunción ejecutiva, transformando objetivos complejos en micro-pasos accionables.

A diferencia de los gestores de tareas convencionales que generan agobio con listas infinitas, FocusFlow utiliza un enfoque cognitivo de **"Acción Única"**, guiando al usuario para que se concentre exclusivamente en el siguiente paso ejecutable.

> “¿Qué tengo que hacer ahora mismo?” — El sistema elimina el ruido para que solo quede la acción.

---

## 🚀 Propuesta de Valor

- **Reducción de Fricción:** Conversión de tareas grandes en pasos de 1-5 minutos.
- **Cero Sobrecarga:** Solo una tarea visible a la vez en el modo foco.
- **Asistencia con IA:** Desglose automático de proyectos complejos mediante inteligencia artificial.
- **Rutinas Guiadas:** Automatización de secuencias diarias para reducir la carga cognitiva matutina y nocturna.

---

## 🧱 Arquitectura del Proyecto

El proyecto sigue una arquitectura **Feature-First** combinada con **Clean Architecture**, diseñada para ser escalable, testeable y fácil de mantener.

### 📦 Estructura General de Carpetas

```text
lib/
├── core/                # Infraestructura global y configuraciones base
├── features/            # Módulos de negocio (autónomos y escalables)
├── shared/              # Recursos de UI y utilidades compartidas
└── main.dart            # Punto de entrada de la aplicación
```

---

### 🧠 Capa CORE (Infraestructura)

Contiene la lógica transversal que soporta a todas las funcionalidades.

```text
core/
├── app/                 # Inicialización y controladores de sesión global
├── cache/               # Persistencia local (LocalStorage/Hive)
├── constants/           # Valores estáticos y strings de la app
├── firebase/            # Configuración de Firebase y servicios core
├── firestore/           # Clientes y definiciones de colecciones
├── router/              # Configuración de navegación (GoRouter)
├── theme/               # Sistema de diseño, colores y tipografía
└── utils/               # Helpers de fechas, validadores, etc.
```

---

### 🧩 Capa FEATURES (Negocio)

Cada funcionalidad está organizada en sub-capas para separar responsabilidades.

```text
features/
├── auth/                # Gestión de identidad y OAuth
├── tasks/               # Núcleo: Creación y gestión de micro-tareas
│   ├── data/            # Repositorios y DataSources (Firebase/Local)
│   ├── domain/          # Entidades puras y Casos de Uso (Usecases)
│   └── presentation/    # Controladores (Riverpod), Screens y Widgets
├── focus/               # Interfaz de ejecución de tarea única
├── routines/            # Secuencias de acciones automatizadas
├── ai/                  # Lógica de desglose de tareas mediante LLMs
├── home/                # Panel principal y navegación rápida
├── widget/              # Componentes para el Home Screen de Android/iOS
└── premium/             # Gestión de suscripciones y límites
```

---

### 🎨 Capa SHARED (Componentes Comunes)

Elementos de UI reutilizables en toda la aplicación para mantener la consistencia.

```text
shared/
├── widgets/             # Botones, Cards y Inputs personalizados
├── dialogs/             # Modales de confirmación y alertas
├── styles/              # Decoraciones y constantes de estilo UI
└── extensions/          # Extensiones de Dart/Flutter (BuildContext, etc.)
```

---

## 🔄 Flujo de Datos (Data Flow)

La comunicación entre capas sigue una dirección única para evitar acoplamientos:

1.  **UI (Widgets):** Captura el evento del usuario.
2.  **Controller (Riverpod):** Gestiona el estado y llama al Caso de Uso.
3.  **UseCase (Domain):** Ejecuta la regla de negocio.
4.  **Repository (Data):** Decide si obtener datos de la nube o caché.
5.  **DataSource:** Realiza la petición técnica (Firebase/API).

---

## ⚙️ Stack Tecnológico

- **Framework:** Flutter
- **Estado:** Riverpod
- **Backend:** Firebase (Auth, Firestore, Functions)
- **Navegación:** GoRouter
- **Persistencia:** Local Storage
- **IA:** Integración con modelos de lenguaje para desglose de tareas.

---

## 🚀 Estado del Proyecto

- [x] Arquitectura Base Definida
- [x] Integración de Firebase
- [x] Flujo de Autenticación
- [ ] MVP de Tareas y Modo Foco (En progreso)
- [ ] Integración de IA para desgloses
