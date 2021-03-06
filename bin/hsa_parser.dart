import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

void main(List<String> arguments) async {
  print('Hello world!');
  final input = File('data/hsa_active.csv').openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  // print(fields);

  final List<String> expedientes = [];

// skips first row (column names)
  for (var i = 1; i < fields.length; i++) {
    final String itemExpediente = fields[i][0];

    // checks for empty expedientes
    if (itemExpediente == '') {
      print(i);
    }

    // checks for duplicated expedientes
    if (expedientes.contains(fields[i][0])) {
      print('Expediente $i está duplicado');
    } else {
      expedientes.add(itemExpediente);
    }

    // checks for valid date at position 13 (last update)
    if (fields[i][13] == '') {
      // print('empty date at $i');
    } else {
      var date = DateTime.tryParse(fields[i][13]);
      date ??= DateTime.tryParse(fields[i][25]);
      if (date == null) print('invalid date at $i');
      // send empty string
    }
  }
  // print(fields[0][25]);
  print(fields[0]);
  print(fields[1]);
  // DateTime.parse('2016-05-27');
  // if (DateTime.tryParse(fields[1][13]) == null) {
  //   print('Date is invalid');
  // }
  // print(expedientes);
}

// [
//   'EXPEDIENTE',
//   'TIPO REPARTO',
//   'PONENTE',
//   'FECHA DE RADICADO AL CNE',
//   'FECHA DE REPARTO',
//   'ASUNTO',
//   'DEPARTAMENTO',
//   'MUNICIPIO',
//   'SOLICITANTE',
//   'REFERENCIA',
//   'ASESOR',
//   'ESTADO',
//   'SUBESTADO',
//   'FECHA ULTIMA ACTUACION',
//   'DETALLE ULTIMA ACTUACION',
//   'TIEMPO EN ESTADO (SEMAFORO) NO DILIGENCIAR',
//   'FECHA HECHO GENERADOR',
//   'FECHA ACTUAL',
//   'DIAS DESDE EL RADICADO (NO DILIGENCIAR)',
//   'FECHA DE CADUCIDAD',
//   'VALIDADO DESPACHO',
//   'ACCION SUBSECRETARIA',
//   'Otros comentarios',
//   'Otros comentarios',
//   'FECHA CADUCIDAD',
// ];
