# Documento de Requerimientos — Pizza App

Última actualización: 25 de noviembre de 2025

Propósito
- Definir claramente el alcance, requisitos funcionales y no funcionales, flujos de usuario, modelos de datos y criterios de aceptación para la aplicación móvil/web "Pizza App".

1. Resumen del producto
- Aplicación de pedidos de pizza con catálogo, detalles de producto, carrito, autenticación (Firebase Auth), y almacenamiento de datos (Cloud Firestore).
- Objetivo: permitir a usuarios autenticados explorar pizzas, añadirlas al carrito, y completar pedidos (próximamente: checkout).

2. Audiencia y actores
- Usuario final (cliente): explora catálogo, gestiona carrito y realiza pedidos.
- Administrador (opcional): gestiona catálogo y pedidos (no implementado actualmente).
- Sistema externo: Firebase Auth, Cloud Firestore (base de datos), hosting (opcional).

3. Requisitos funcionales (RF)
RF-01 Autenticación
- El usuario puede iniciar/cerrar sesión usando correo/contraseña con Firebase Auth.
- Al registrarse, se crea un documento `users/{uid}` en Firestore con los datos básicos.

RF-02 Catálogo de pizzas
- Mostrar lista de pizzas: imagen, nombre, descripción, precio, descuento, indicador veg/non-veg y nivel picante.
- Soportar paginación o carga por lotes (mejora futura).

RF-03 Detalle de producto
- Mostrar información ampliada de cada pizza y botón para "Añadir al carrito".

RF-04 Carrito
- El usuario puede añadir/quitar y cambiar cantidad de items en el carrito (estado en memoria actualmente).
- Mostrar resumen (cantidad total, precio total) en una barra inferior o modal.

RF-05 Checkout (alcance mínimo)
- Botón "Order Now" que actúe como placeholder para flujo de pago (implementación de pago quedará fuera de esta fase).

RF-06 Imágenes robustas
- Intentar cargar imágenes de red y, si fallan, usar imagen local por defecto.

4. Requisitos no funcionales (RNF)
RNF-01 Rendimiento
- Tiempo de respuesta de la UI: < 200ms para interacciones básicas en dispositivos modernos.

RNF-02 Disponibilidad
- Soportar modo offline parcial: mostrar caché o mensajes adecuados cuando Firestore no esté accesible (mejoras futuras).

RNF-03 Seguridad
- No almacenar secrets ni archivos `google-services.json` o `GoogleService-Info.plist` en el repo público.
- Reglas de Firestore deben proteger escritura/lectura según UID (reglas definidas por proyecto Firebase).

RNF-04 Accesibilidad
- Textos con contraste adecuado, tamaños escalables, y botones con tamaño táctil mínimo.

RNF-05 Portabilidad
- Soportar Android, iOS y Web. Evitar APIs nativas no soportadas en Web o proveer alternativas.

5. Modelos de datos (propuesta)
- Pizza
  - id: string
  - name: string
  - description: string
  - price: number (entero)
  - discount: int (porcentaje)
  - picture: string (URL o path local)
  - isVeg: bool
  - spicy: int (1=bland,2=balance,3=spicy)

- CartItem
  - pizzaId: string
  - name: string
  - unitPrice: number
  - qty: int
  - picture: string

- User (Firestore `users/{uid}`)
  - uid: string
  - email: string
  - displayName: string
  - isAdmin: bool (opcional)
  - createdAt: timestamp

6. Flujos de usuario críticos
- Inicio -> Autenticación -> Home
- Home -> Detalle -> Añadir al carrito -> ver carrito -> Order Now
- SignUp -> crear doc en Firestore -> redirigir a Home

7. API / Integraciones
- Firebase Auth: login, logout, registro.
- Firestore: colección `pizzas` (lectura pública con reglas) y `users`.
- (Opcional) Cloud Functions / Pago: integraciones futuras.

8. Requisitos de prueba y aceptación
8.1 Criterios de aceptación (por RF clave)
- RF-01: Registro crea documento `users/{uid}` y el usuario queda autenticado.
- RF-02: El catálogo muestra al menos 5 pizzas de ejemplo y las imágenes caídas usan la imagen local por defecto.
- RF-03: Añadir al carrito incrementa `totalItems` y `totalPrice` en la barra inferior.
- RF-04: En pantallas pequeñas no debe ocurrir RenderFlex overflow en la UI principal.

8.2 Pruebas recomendadas
- Unit tests: BLoCs/Cubits (GetPizzaBloc, CartCubit, AuthenticationBloc).
- Widget tests: `HomeScreen` list rendering, `CartScreen` manipulación de cantidades.
- Integración: flujo completo login -> añadir al carrito -> ver total.

9. Despliegue y entorno de desarrollo
- Requisitos locales: Flutter SDK (recomendado canal `stable`), Dart SDK compatible, Android SDK/Emulador o Chrome para web.
- Variables/archivos sensibles: `android/app/google-services.json`, `ios/GoogleService-Info.plist`, `lib/firebase_options.dart` deben mantenerse fuera del repo (usar `.gitignore` y muestras `.sample`).
- Comandos útiles:
  - `flutter pub get`
  - `flutter analyze`
  - `flutter run -d chrome` (o `-d emulator-5554` para Android)

10. Tareas / Hitos
- Hito 1: Estabilizar catálogo y detalles (UI responsive y manejo de imágenes). (COMPLETADO parcial)
- Hito 2: Implementar carrito y persistencia local (SharedPreferences / Hive). (ACCIÓN: reimplementar en rama feature)
- Hito 3: Checkout básico e integración de pagos (fuera de alcance inicial).

11. Restricciones y supuestos
- La app usará Firebase como backend; el equipo tiene acceso al proyecto Firebase y sabe configurar credenciales locales.
- No se requiere pasarela de pago en la fase inicial.
- Las reglas de Firestore se crearán para que solo usuarios autenticados puedan escribir su propio documento `users/{uid}`.

12. Riesgos
- Reglas de Firestore mal configuradas → lecturas/consultas fallan en tiempo de ejecución.
- Imágenes externas no confiables → añadir fallback local obligatorio.
- Manipulación de estado antes de que los providers estén montados → ProviderNotFoundException (mitigado con defensas en UI).

13. Recomendaciones
- Mantener `CartCubit` provisto en el nivel superior del árbol cuando `HomeScreen` u otras pantallas la consuman.
- Persistir carrito localmente para mejorar UX y permitir reload sin pérdida.
- Añadir CI que corra `flutter analyze` y pruebas unitarias.

14. Anexos
- `README.md` contiene instrucciones de configuración básica y archivo `android/google-services.json.sample` como guía.

---
Notas: Este documento es una base. Podemos convertirlo a formato más formal (plantilla IEEE o formato ágil con historias de usuario) si lo prefieres.
