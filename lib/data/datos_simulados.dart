// Datos de prueba (todavía no hay base de datos)
import '../models/movimiento.dart';
import '../models/producto.dart';
import '../models/transaccion.dart';
import '../models/usuario.dart';

final List<Producto> productos = [
  Producto(
      nombre: 'Café Frío',
      descripcion: 'Batido frío artesanal',
      precio: 85,
      categoria: 'Bebida Fría',
      stock: 12),
  Producto(
      nombre: 'Frappé',
      descripcion: 'Café frappé con hielo y crema',
      precio: 95,
      categoria: 'Bebida Fría',
      stock: 8),
  Producto(
      nombre: 'Capuchino',
      descripcion: 'Espresso con leche espumada',
      precio: 90,
      categoria: 'Caliente',
      stock: 3),
  Producto(
      nombre: 'Café Latte',
      descripcion: 'Espresso con abundante leche',
      precio: 90,
      categoria: 'Caliente',
      stock: 15),
  Producto(
      nombre: 'Mocaccino',
      descripcion: 'Espresso con chocolate y leche',
      precio: 80,
      categoria: 'Caliente',
      stock: 6),
  Producto(
      nombre: 'Granos Selectos',
      descripcion: 'Café en grano, bolsa de 1 lb',
      precio: 250,
      categoria: 'Insumo',
      stock: 25),
  Producto(
      nombre: 'Leche',
      descripcion: 'Leche entera, litro',
      precio: 45,
      categoria: 'Insumo',
      stock: 2),
  Producto(
      nombre: 'Vainilla',
      descripcion: 'Esencia de vainilla',
      precio: 30,
      categoria: 'Insumo',
      stock: 0),
];

final List<Transaccion> ventas = [
  Transaccion(
      codigo: 'Venta #001',
      detalle: 'Café Latte x2',
      fecha: '25/09/2026 - 10:35 AM',
      total: 180),
  Transaccion(
      codigo: 'Venta #002',
      detalle: 'Capuchino x1',
      fecha: '25/09/2026 - 11:20 AM',
      total: 90),
  Transaccion(
      codigo: 'Venta #003',
      detalle: 'Mocaccino x2',
      fecha: '25/09/2026 - 12:05 PM',
      total: 160),
  Transaccion(
      codigo: 'Venta #004',
      detalle: 'Café Frío x3',
      fecha: '26/09/2026 - 09:10 AM',
      total: 255),
];

final List<Transaccion> compras = [
  Transaccion(
      codigo: 'Compra #101',
      detalle: 'Granos Selectos x10',
      fecha: '20/09/2026 - 08:00 AM',
      total: 2500),
  Transaccion(
      codigo: 'Compra #102',
      detalle: 'Leche x24',
      fecha: '22/09/2026 - 02:30 PM',
      total: 1080),
  Transaccion(
      codigo: 'Compra #103',
      detalle: 'Vainilla x6',
      fecha: '24/09/2026 - 10:15 AM',
      total: 180),
];

final List<Movimiento> movimientos = [
  Movimiento(
      producto: 'Leche', cantidad: 4, motivo: 'Caducado', fecha: '22/09/2026'),
  Movimiento(
      producto: 'Café Frío',
      cantidad: 2,
      motivo: 'Dañado',
      fecha: '24/09/2026'),
  Movimiento(
      producto: 'Vainilla',
      cantidad: 1,
      motivo: 'Perdido',
      fecha: '25/09/2026'),
  Movimiento(
      producto: 'Capuchino',
      cantidad: 3,
      motivo: 'Dañado',
      fecha: '26/09/2026'),
];

final List<Usuario> usuarios = [
  Usuario(
      nombre: 'Diana García',
      email: 'admin@purisimocafe.com',
      rol: 'Administrador'),
  Usuario(
      nombre: 'Steven Hernández',
      email: 'admin@purisimocafe.com',
      rol: 'Administrador'),
  Usuario(
      nombre: 'Yaoska Nicaragua',
      email: 'cajero@purisimocafe.com',
      rol: 'Cajero'),
  Usuario(
      nombre: 'Mabelin Zeledon',
      email: 'cajero@purisimocafe.com',
      rol: 'Cajero',
      activo: false),
];

// Ventas para las gráficas de Reportes
final Map<String, double> ventasSemana = {
  'Lun': 420,
  'Mar': 380,
  'Mié': 510,
  'Jue': 295,
  'Vie': 640,
  'Sáb': 720,
  'Dom': 350,
};

final Map<String, double> ventasMes = {
  'Sem 1': 2800,
  'Sem 2': 3400,
  'Sem 3': 3100,
  'Sem 4': 3900,
};
