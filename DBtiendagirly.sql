CREATE DATABASE moxxie;
USE moxxie;

CREATE TABLE Categorias
(
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Descripcion TEXT
);

CREATE TABLE Marcas
(
    ID_Marca INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Descripcion TEXT
);

CREATE TABLE Proveedores
(
    ID_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Telefono VARCHAR(20),
    Email VARCHAR(50),
    Direccion TEXT
);

CREATE TABLE Sucursales
(
    ID_Sucursal INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Direccion TEXT,
    Telefono VARCHAR(20)
);

CREATE TABLE Productos
(
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Precio DECIMAL(10, 2),
    Talla VARCHAR(10),
    Color VARCHAR(50),
    ID_Categoria INT,
    ID_Proveedor INT,
    ID_Marca INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor),
    FOREIGN KEY (ID_Marca) REFERENCES Marcas(ID_Marca)
);

CREATE TABLE Clientes
(
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion TEXT
);

CREATE TABLE Empleados
(
    ID_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(100),
    Puesto VARCHAR(50),
    Salario DECIMAL(10, 2),
    Telefono VARCHAR(20),
    Direccion TEXT
);

CREATE TABLE Ventas
(
    ID_Venta INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Venta DATETIME,
    ID_Cliente INT,
    ID_Empleado INT,
    Total DECIMAL(10, 2),
    ID_MetodoPago INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado),
    FOREIGN KEY (ID_MetodoPago) REFERENCES MetodosPago(ID_MetodoPago)
);

CREATE TABLE DetalleVentas
(
    ID_Detalle INT,
    ID_Venta INT,
    ID_Producto INT,
    Cantidad INT,
    Precio DECIMAL(10, 2),
    PRIMARY KEY (ID_Producto, ID_Venta),
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE Pedidos
(
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Pedido DATE,
    Fecha_Entrega DATETIME,
    Estado VARCHAR(20),
    ID_Proveedor INT,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor)
);

CREATE TABLE DetallePedidos
(
    ID_Detalle INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT,
    Cantidad INT,
    Nombre_Producto VARCHAR(50),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido)
);

CREATE TABLE Devoluciones
(
    ID_Devolucion INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Devolucion DATETIME,
    ID_Venta INT,
    ID_Producto INT,
    Cantidad INT,
    Motivo TEXT,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE Inventario
(
    ID_Inventario INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Inventario DATE NOT NULL,
    ID_Producto INT NOT NULL,
    Umbral_Minimo INT DEFAULT 50,
    Cantidad_Total INT DEFAULT 0,
    Fecha_Creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    Fecha_Modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE MovimientosInventario
(
    ID_Movimiento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT NOT NULL,
    TipoMovimiento ENUM('Entrada', 'Salida') NOT NULL,
    Cantidad INT NOT NULL,
    FechaMovimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    Descripcion TEXT,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE InventarioSucursal
(
    ID_Sucursal INT,
    ID_Producto INT,
    Cantidad INT DEFAULT 0,
    PRIMARY KEY (ID_Sucursal, ID_Producto),
    FOREIGN KEY (ID_Sucursal) REFERENCES Sucursales(ID_Sucursal),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE Descuentos
(
    ID_Descuento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT,
    PorcentajeDescuento DECIMAL(5, 2),
    FechaInicio DATE,
    FechaFin DATE,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

CREATE TABLE MetodosPago
(
    ID_MetodoPago INT AUTO_INCREMENT PRIMARY KEY,
    Metodo VARCHAR(50)
);

CREATE TABLE Usuarios
(
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    ID_Empleado INT,
    Usuario VARCHAR(50) UNIQUE NOT NULL,
    Contraseña_Hash VARCHAR(255) NOT NULL,
    Rol ENUM('Administrador', 'Vendedor', 'Gerente') NOT NULL,
    Activo BOOLEAN DEFAULT TRUE,
    Fecha_Creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Empleado) REFERENCES Empleados(ID_Empleado)
);
