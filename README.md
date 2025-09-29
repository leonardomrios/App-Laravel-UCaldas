# Laravel 2025-2 - Proyecto CRUD de Computers

Este proyecto es una API RESTful construida con Laravel que incluye un CRUD completo para la entidad `computers`.

## Requisitos
- PHP >= 8.1
- Composer
- Base de datos (MySQL, PostgreSQL, etc.)
- Git

## Instalación y configuración

Sigue estos pasos en tu terminal o Git Bash:

1. **Clona el repositorio:**
	 ```sh
	 git clone <URL_DEL_REPOSITORIO>
	 cd laravel-2025-2-main
	 ```

2. **Configura el archivo de entorno:**
	 ```sh
	 cp .env.example .env
	 ```
	 Edita el archivo `.env` y coloca los datos de tu base de datos.

3. **Instala las dependencias:**
	 ```sh
	 composer install
	 ```

4. **Genera la clave de la aplicación:**
	 ```sh
	 php artisan key:generate
	 ```

5. **Ejecuta las migraciones y seeders:**
	 ```sh
	 php artisan migrate --seed
	 ```
	 Esto creará la tabla `computers` y la poblará con datos de prueba.

6. **Inicia el servidor de desarrollo:**
	 ```sh
	 php artisan serve
	 ```
	 El proyecto estará disponible en `http://localhost:8000`

## Probar el CRUD de Computers

Puedes usar herramientas como Postman, Insomnia o curl. Ejemplos con curl:

- **Listar computers:**
	```sh
	curl -X GET http://localhost:8000/api/computers
	```
- **Ver un computer:**
	```sh
	curl -X GET http://localhost:8000/api/computers/1
	```
- **Crear un computer:**
	```sh
	curl -X POST http://localhost:8000/api/computers \
		-H "Content-Type: application/json" \
		-d '{"computer_brand":"HP","computer_model":"Pavilion","computer_price":1200,"computer_ram_size":16,"computer_is_laptop":true}'
	```
- **Actualizar un computer:**
	```sh
	curl -X PUT http://localhost:8000/api/computers/1 \
		-H "Content-Type: application/json" \
		-d '{"computer_brand":"Dell","computer_model":"Inspiron","computer_price":1500,"computer_ram_size":32,"computer_is_laptop":false}'
	```
- **Eliminar un computer:**
	```sh
	curl -X DELETE http://localhost:8000/api/computers/1
	```

> Si usas autenticación, agrega el header `Authorization: Bearer TU_TOKEN`.

---

¡Listo! Cualquier persona puede instalar y probar el CRUD de computers siguiendo estos pasos.
<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Redberry](https://redberry.international/laravel-development)**
- **[Active Logic](https://activelogic.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
