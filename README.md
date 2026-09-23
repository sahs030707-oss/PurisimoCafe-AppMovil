## Estructura de carpetas

```
lib/
├── main.dart
├── constants/        # Colores y valores compartidos por toda la app
├── models/           # Clases de datos (Usuario, Producto, Categoria...)
├── services/         # Futuras conexiones a backend/API
├── widgets/           # Widgets usados en 2+ pantallas
└── screens/
    └── nombre_pantalla/
        ├── nombre_pantalla.dart
        └── widgets/    # Widgets exclusivos de ESA pantalla
```

**Regla simple:** si un widget solo lo usa una pantalla, va dentro de
`screens/esa_pantalla/widgets/`. Si lo usan dos o más pantallas, va en
`lib/widgets/`.

## Reglas del equipo

1. Nunca trabajar directamente sobre `MASTER`.

2. Cada integrante trabaja únicamente en su propia rama (con su nombre).

3. Un commit, un cambio claro — mensajes descriptivos (ej. `agrega
   pantalla de login con validaciones`, no `cambios`).

4. Antes de crear el Pull Request, actualizar la rama con los últimos
   cambios de `MASTER` (ver flujo abajo) para evitar conflictos grandes.

5. No modificar archivos de la pantalla de otro integrante sin
   coordinarlo primero.

6. Cada pantalla nueva va en su propia carpeta dentro de `screens/`.

7. Usar siempre los colores de `constants/app_colors.dart`, no
   valores sueltos.

## Flujo de trabajo (Git)

### 1. Clonar el repositorio (una sola vez, cada integrante)
```bash
git clone <URL-del-repositorio>
cd purisimocafe_appmovil
flutter pub get
```

### 2. Crear tu rama (una sola vez)
```bash
git checkout MASTER
git pull origin MASTER
git checkout -b steven          # cambia "steven" por tu nombre
git push -u origin steven
```

### 3. Trabajar en tu pantalla
Coloca tu pantalla dentro de `lib/screens/tu_pantalla/`, siguiendo la
estructura de arriba. Guarda y prueba con `flutter run` o F5.

### 4. Commit y push
```bash
git add .
git commit -m "agrega pantalla de login con validaciones"
git push
```
Puedes repetir commit + push varias veces mientras avanzas — eso es
justamente lo que deja evidencia de tu trabajo individual.

### 5. Antes del Pull Request: actualizar tu rama
```bash
git checkout MASTER
git pull origin MASTER
git checkout steven
git merge MASTER
```
Si hay conflictos, resuélvelos aquí, en tu rama (no en MASTER).

### 6. Crear el Pull Request
En GitHub: `Pull requests → New pull request` → base `MASTER` ←
compare `steven`. Describe brevemente qué pantalla agregaste.

### 7. Revisión y Merge
Otro integrante (o quien acordaron) revisa el código y aprueba el
PR. Al aceptarlo, se integra a `MASTER`.

### 8. Después del merge
```bash
git checkout MASTER
git pull origin MASTER
```
Así tu rama local queda al día con lo que ya integraron los demás.