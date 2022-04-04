class Payament{
    // CONFIGURAÇÕES
 String posID = "90000190";
 String posAutCode = "nlXxmDoCJBibmCJQ";

 // OBTER DADOS DE PAGAMENTO
String amount = "1000";
/*
String merchantRef = "R"+DateTime.now().toString();
String merchantSession = "S" +DateTime.now().toString();
String dateTime = DateTime.now().toString();*/
String entityCode = "";
String referenceNumber = "";

// URL PARA RECEBER RESPOSTA/RESULTADO DO PAGAMENTO
String responseUrl = "http://www.meusite.com/resposta_pagamento.php";

/*
// DADOS A ENVIAR
var fields = [
'transactionCode': '1',
'posID': '90051',
'merchantRef': merchantRef,
'merchantSession': merchantSession,
'amount' : amount,
'currency' : '132',
'is3DSec' : '1',
'urlMerchantResponse' : responseUrl,
'languageMessages' : 'en',
'timeStamp' : dateTime,
'fingerprintversion' : '1'
];*/

// GERAR PRINGER PRINT E ADICIONAR AOS DADOS DE ENVIO
/*fields['fingerprint'] = GerarFingerPrintEnvio(
posAutCode, fields['timeStamp'], amount,
fields['merchantRef'], fields['merchantSession'], fields['posID'],
 fields['currency'], fields['transactionCode'], entityCode, referenceNumber
);

 GerarFingerPrintEnvio(posAutCode, timestamp, amount,merchantRef, merchantSession, posID,currency, transactionCode, entityCode,referenceNumber)
{
    // final bytes = utf8.encode(str);
  //final base64Str = base64.encode(bytes);

return null;
}*/

}