# 📚 Sistema de Gestión de Abogados - API

API REST construida en **Node.js + Express + MySQL** para administrar **clientes, casos y audiencias** de un estudio jurídico.

---

## 🚀 Instalación y configuración

```bash
# Clonar repositorio
git clone <url-repo>
cd sistema-abogados

# Instalar dependencias
npm install

# Configurar variables de entorno (ejemplo .env)
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password
DB_NAME=abogados

# Configura la base de datos MySQL:
# - Crea una base de datos llamada abogados_db.
# - Actualiza la configuración de la base de datos en bd/mysql.js con tus credenciales de MySQL (host, usuario, contraseña).
# - Asegúrate de que las tablas requeridas (audiencias, casos, clientes) estén creadas.

# Ejecutar servidor
npm start
```

Servidor se levanta por defecto en:
👉 `http://localhost:3000`

---

## 📂 Endpoints disponibles

### 👤 Clientes

| Método | Endpoint        | Descripción                     | Ejemplo body (JSON)                                                                                                                                                                               |
| ------ | --------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/clientes`     | Listar todos los clientes       | -                                                                                                                                                                                                 |
| GET    | `/clientes/:id` | Obtener un cliente por ID       | -                                                                                                                                                                                                 |
| POST   | `/clientes`     | Crear un nuevo cliente          | `json { "nombre": "Juan", "apellido_paterno": "Pérez", "apellido_materno": "Gómez", "tipo_documento": "DNI", "nro_documento": "12345678", "email": "juan@example.com", "telefono": "987654321" }` |
| PUT    | `/clientes/:id` | Actualizar un cliente existente | `json { "nombre": "Juan Carlos", "telefono": "912345678" }`                                                                                                                                       |

---

### 📂 Casos

| Método | Endpoint     | Descripción                  | Ejemplo body (JSON)                                                                                                                                                                                                                                                                             |
| ------ | ------------ | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/casos`     | Listar todos los casos       | -                                                                                                                                                                                                                                                                                               |
| GET    | `/casos/:id` | Obtener un caso por ID       | -                                                                                                                                                                                                                                                                                               |
| POST   | `/casos`     | Crear un nuevo caso          | `json {"cliente_id": 1,"titulo": "Demanda laboral por despido","descripcion": "El cliente alega despido arbitrario en su empresa"}` 																			         |
| PUT    | `/casos/:id` | Actualizar un caso existente | `json {"cliente_id": 1,"titulo": "Demanda laboral por despido","descripcion": "El cliente alega despido arbitrario en su empresa modificado"}` 																			         |

---

### 📂 Audiencias

| Método | Endpoint          | Descripción                        | Ejemplo body (JSON)                                                                                                                         |
| ------ | ----------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/audiencias`     | Listar todas las audiencias        | -                                                                                                                                           |
| GET    | `/audiencias/:id` | Obtener una audiencia por ID       | -                                                                                                                                           |
| POST   | `/audiencias`     | Crear una nueva audiencia          | `json { "caso_id": 1, "fecha": "2025-10-20 09:30:00", "lugar": "Juzgado Laboral N°2", "descripcion": "Primera audiencia de conciliación" }` |
| PUT    | `/audiencias/:id` | Actualizar una audiencia existente | `json { "descripcion": "Reprogramación de audiencia", "fecha": "2025-11-05 10:00:00" }`                                                     |

---

## 🛠️ Tecnologías usadas

* Node.js
* Express
* MySQL (mysql2)
* CORS

---

## 📌 Notas

* Todos los endpoints devuelven **JSON**.
* Los errores se responden con código HTTP adecuado (`400`, `404`, `500`).
* Se recomienda usar **Postman** o **Insomnia** para pruebas.

---

👨‍⚖️ Desarrollado para gestión eficiente de un estudio jurídico.
