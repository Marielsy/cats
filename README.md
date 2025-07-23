# Cats App

Cats App es una aplicación Flutter que permite a los usuarios explorar diferentes razas de gatos, ver detalles específicos de cada raza y descubrir información relevante de manera visual y sencilla. La aplicación está diseñada para ser intuitiva, rápida y visualmente atractiva, ideal tanto para amantes de los gatos como para quienes desean aprender más sobre ellos.

## Características principales

- **Listado de razas de gatos:** Muestra una galería de razas con imágenes y nombres.
- **Detalle de raza:** Permite consultar información detallada sobre cada raza, incluyendo descripción, características y fotografía.
- **Búsqueda eficiente:** Los usuarios pueden buscar razas por nombre de forma ágil.
- **Splash screen animado:** Al iniciar la app se muestra una animación de gatos usando Lottie ([ver animación](https://lottiefiles.com/animations/lovely-cats-pC7tXBvH8V?from=search)).
- **Consumo de API externa:** Todas las consultas de razas y detalles se realizan usando la API pública de [TheCatAPI](https://thecatapi.com/).
- **Arquitectura limpia:** Separación clara entre presentación, lógica de negocio y acceso a datos.
- **Rendimiento optimizado:** Interfaz fluida y navegación eficiente.

---

## Estructura de Pantallas

### 1. Splash Screen

- **Propósito:** Mostrar una animación atractiva de gatos mientras la app se inicializa.
- **Funcionalidad:**
  - Animación Lottie de gatos: [Lovely Cats - LottieFiles](https://lottiefiles.com/animations/lovely-cats-pC7tXBvH8V?from=search).
  - Transición automática a la pantalla de inicio tras la carga.

---

### 2. Pantalla de Inicio (`HomeScreen`)

- **Propósito:** Presenta una lista de todas las razas de gatos disponibles.
- **Funcionalidad:**
  - Visualización de tarjetas con imagen y nombre de cada raza.
  - Barra de búsqueda para filtrar razas por nombre.
  - Navegación a la pantalla de detalles al seleccionar una raza.
- **Experiencia de usuario:** Interfaz limpia y moderna, con scroll fluido y carga eficiente de imágenes.

---

### 3. Pantalla de Detalle de Raza (`BreedDetailScreen`)

- **Propósito:** Muestra información completa sobre la raza seleccionada.
- **Funcionalidad:**
  - Imagen destacada de la raza.
  - Descripción general y características específicas (origen, temperamento, tamaño, etc.).
  - Botón para volver a la pantalla de inicio.
- **Experiencia de usuario:** Diseño enfocado en la información visual y textual, con fácil navegación hacia atrás.

---

## Estructura del Proyecto

- `lib/main.dart`: Punto de entrada de la aplicación.
- `lib/features/home/presentation/home_screen.dart`: Pantalla principal con listado de razas.
- `lib/features/breed_detail/presentation/breed_detail_screen.dart`: Pantalla de detalle de raza.
- `lib/features/breed_detail/domain/repositories/breed_repository.dart`: Lógica de acceso a datos de razas.
- `lib/features/home/presentation/home_provider.dart`: Gestión del estado y lógica de la pantalla de inicio.

---[MyPlayground.playground.zip](https://github.com/user-attachments/files/21392788/MyPlayground.playground.zip)

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-23 at 12 23 49" src="https://github.com/user-attachments/assets/c465a90f-1cd1-4d0a-b444-011ea8ea5bc4" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-23 at 12 23 53" src="https://github.com/user-attachments/assets/9008ebd9-c64c-443e-ae6f-69a844919d9c" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-23 at 12 23 54" src="https://github.com/user-attachments/assets/e7002750-5961-4724-8d23-8c0514a5adc1" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-23 at 12 24 00" src="https://github.com/user-attachments/assets/ad803796-cadd-4402-9d05-1e20aa53eab7" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-23 at 12 23 52" src="https://github.com/user-attachments/assets/ce5ae55e-97a5-4f95-826b-f223e5c45fa9" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-23 at 12 24 16" src="https://github.com/user-attachments/assets/6f1098aa-54ca-4c82-a0cd-72a82b36f15b" />


## Instalación y Ejecución

1. Clona este repositorio:
   ```bash
   git clone <url-del-repositorio>
   cd cats

