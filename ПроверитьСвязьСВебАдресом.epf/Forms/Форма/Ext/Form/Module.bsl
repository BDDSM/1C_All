﻿//
//
//
//

//
//
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
КонецПроцедуры

//
//
//
&НаКлиенте
Процедура ПроверитьСвязьСВебАдресом(Команда)
	ОчиститьСообщения();
	ПроверитьСвязьСВебАдресомНаСервере();
КонецПроцедуры

//
//
//
//
&НаСервере
Процедура ПроверитьСвязьСВебАдресомНаСервере()
	
	Если ЗащищенноеСоединение Тогда 
		Соединение = Новый HTTPСоединение(АдресВебПриложения,порт,,,,,Новый ЗащищенноеСоединениеOpenSSL);
	Иначе 
		Соединение = Новый HTTPСоединение(АдресВебПриложения,порт,,,,,)
	КонецЕсли;
	
	Запрос = Новый HTTPЗапрос("/");
	
	Попытка
		Результат = Соединение.Получить(Запрос);
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;

КонецПроцедуры
