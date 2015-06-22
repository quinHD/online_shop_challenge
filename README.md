# Online Shop Challenge

###Exercise

Imagina que estamos implementando una tienda online, que vende solo 3 productos:

Codigo | Nombre       | Precio
------ | -------      | ------
AM     | Agua mineral | 3.11€
AC     | Aceite       | 5.00€
CA     | Cafe         | 11.23€

El departamento de marketing es fan de las promociones de tipo 2x1 (si compras dos productos iguales, uno de ellos es gratis). Y quiere que haya un descuento de este tipo en Agua mineral.
El CEO cree que lo mejor para aumentar las ventas es agregar descuentos por cantidad (al comprar x de un mismo producto, el precio por unidad baja). Y quiere que al comprar 3 o mas aceites, el precio por unidad sea de 4.50€.
El proceso de checkout permite escanear los productos en cualquier orden y debe devolver el total de la compra.

### Running the tests

```sh
$ rspec Shop_spec.rb
```
