﻿Процедура ПолучитьМинимальноеЗначениеПоИндексуМассива()  Экспорт 
	
	ТекущийМассив = Новый Массив;
	Для ИндексВ=1 По 100 Цикл 
	    ТекущийМассив.Добавить(ИндексВ)
	КонецЦикла;	
		
		Список = Новый СписокЗначений; // Подготовительные действия: создание списка значений
		Список.ЗагрузитьЗначения(ТекущийМассив); // Этап 1
		Список.СортироватьПоЗначению(НаправлениеСортировки.Возр); // Этап 2
		ТекущийМассив = Список.ВыгрузитьЗначения(); // Этап 3
		вот = ТекущийМассив[0]
		
	КонецПроцедуры