﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	AndroidSDK = Параметры.AndroidSDK;
	JavaSDK = Параметры.JavaSDK;
	ФайлКлюча = Параметры.ФайлКлюча;
	ПсевдонимКлюча = Параметры.ПсевдонимКлюча;
	ПарольКлюча = Параметры.ПарольКлюча;
	РезультатДляAndroid = Параметры.РезультатДляAndroid;
	РезультатДляiOS = Параметры.РезультатДляiOS;
	МобильнаяПлатформа = Параметры.МобильнаяПлатформа;
	
КонецПроцедуры

// Функция проверяет существование файла
&НаКлиенте
Функция ФайлСуществует(ИмяФайла)
	
	Файл = Новый Файл(ИмяФайла);
	Возврат Файл.Существует();
	
КонецФункции

&НаКлиенте
Функция ВыбратьКаталог(Заголовок, ТекущийКаталог, ПроверяемыйФайл, СообщениеОбОшибке)
	
	Файл = Новый Файл(ТекущийКаталог+"\aux");
	ВыборКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ВыборКаталога.Заголовок = Заголовок;
	ВыборКаталога.Каталог = Файл.Путь;
	Пока Истина Цикл 
		Если ВыборКаталога.Выбрать() Тогда
			Если ПроверяемыйФайл <> Неопределено Тогда
				Если ФайлСуществует(ВыборКаталога.Каталог + "\" + ПроверяемыйФайл) Тогда
					ТекущийКаталог = ВыборКаталога.Каталог + "\";
					Возврат Истина;
				Иначе
					Предупреждение(СообщениеОбОшибке);
					Продолжить;
				КонецЕсли;
			Иначе
				ТекущийКаталог = ВыборКаталога.Каталог + "\";
				Возврат Истина;
			КонецЕсли;
		КонецЕсли;
		Прервать;
	КонецЦикла;
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Процедура AndroidSDKНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьКаталог(НСтр("ru='Выберите каталог размещения Android SDK';en='Specify Android SDK installation directory'", "ru"),
				AndroidSDK,
				"platform-tools\aapt.exe",
				НСтр("ru='Выбранный катлог не содержит Android SDK';en='Specified directory does not contain Android SDK'", "ru"));
	
КонецПроцедуры

&НаКлиенте
Процедура JavaSDKНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьКаталог(НСтр("ru='Выберите каталог размещения Java SDK';en='Specify Java SDK installation directory'", "ru"),
				JavaSDK,
				"bin\jar.exe",
				НСтр("ru='Выбранный катлог не содержит Java SDK';en='Specified directory does not contain Java SDK'", "ru"));
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлКлючаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогОткрытияФайла.ПолноеИмяФайла = ФайлКлюча;
	ДиалогОткрытияФайла.Заголовок = НСтр("ru='Выбор файла ключа';en='Select key file'", "ru");
	ДиалогОткрытияФайла.Фильтр = НСтр("ru='Файлы ключей';en='Key files'", "ru") + " (*.key)|*.key";
	Если ДиалогОткрытияФайла.Выбрать() Тогда
		ФайлКлюча = ДиалогОткрытияФайла.ПолноеИмяФайла;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ФайлКлючаОткрытие(Элемент, СтандартнаяОбработка)
	
	// Откроем каталог, в котором должен быть файл ключа
	СтандартнаяОбработка = Ложь;
	Если ПустаяСтрока(ФайлКлюча) Тогда
		Возврат;
	КонецЕсли;
	Файл = Новый Файл(ФайлКлюча);
	ЗапуститьПриложение("explorer " + Файл.Путь);
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьФайлКлюча(Команда)
	
	ОчиститьСообщения();
	РеквизитыСертификата = Новый Массив;
	РеквизитыСертификата.Добавить("КлючИмя");
	РеквизитыСертификата.Добавить("КлючПодразделение");
	РеквизитыСертификата.Добавить("КлючОрганизация");
	РеквизитыСертификата.Добавить("КлючГород");
	РеквизитыСертификата.Добавить("КлючОбласть");
	РеквизитыСертификата.Добавить("КлючСтрана");
	ЕстьОшибки = Ложь;
	Ошибки = Неопределено;
	Данные = Новый Массив;
	Данные.Добавить(Новый Структура("Ключ, Значение, Реквизит", "Файл", JavaSDK + "bin\keytool.exe", "JavaSDK"));
	Данные.Добавить(Новый Структура("Ключ, Значение, Реквизит", "ПарольКлюча", ПарольКлюча, "ПарольКлюча"));
	Данные.Добавить(Новый Структура("Ключ, Значение, Реквизит", "ПсевдонимКлюча", ПсевдонимКлюча, "ПсевдонимКлюча"));
	Данные.Добавить(Новый Структура("Ключ, Значение, Реквизит", "ФайлКлюча", ФайлКлюча, "ФайлКлюча"));
	Результат = ЭтаФорма.ВладелецФормы.ПроверитьКорректностьРеквизитов(Данные, Ошибки);
	РеквизитыНеЗаполнены = Истина;
	Для каждого РеквизитСертификата Из РеквизитыСертификата Цикл
		Если не ПустаяСтрока(ЭтаФорма[РеквизитСертификата]) Тогда
			РеквизитыНеЗаполнены = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	Если РеквизитыНеЗаполнены Тогда
		Результат = Истина;
		Ошибки.Добавить(Новый Структура("Текст, Реквизит", НСтр("ru='Не указаны параметры сертификата';en='Certificate parameters not specified'", "ru"), "СформироватьФайлКлюча"));
	КонецЕсли;
	Если Результат Тогда
		Для каждого Ошибка Из Ошибки Цикл
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = Ошибка.Текст;
			Сообщение.Поле = Ошибка.Реквизит;
			Сообщение.Сообщить();
		КонецЦикла;
		ЕстьОшибки = Истина;
	КонецЕсли;
	Если ЕстьОшибки Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(ФайлКлюча) Тогда
		Если ФайлСуществует(ФайлКлюча) Тогда
			Результат = Вопрос(НСтр("ru='Указанный файл ключа существует. Удалить существующий файл и сформировать новый файл ключа?';en='Specified key file already exists. Delete the existing fie and generate a new one?'", "ru"), РежимДиалогаВопрос.ДаНет);
			Если Результат = КодВозвратаДиалога.Да Тогда
				УдалитьФайлы(ФайлКлюча);
			Иначе
				Возврат;
			КонецЕсли;
		КонецЕсли;
		КодВозврата = Неопределено;
		dname = """" + ?(ПустаяСтрока(КлючИмя), "", "CN=" + КлючИмя) +
			?(ПустаяСтрока(КлючПодразделение), "", " OU=" + КлючПодразделение) +
			?(ПустаяСтрока(КлючОрганизация), "", " O=" + КлючОрганизация) +
			?(ПустаяСтрока(КлючГород), "", " L=" + КлючГород) +
			?(ПустаяСтрока(КлючОбласть), "", " S=" + КлючОбласть) +
			?(ПустаяСтрока(КлючСтрана), "", " C=" + КлючСтрана) + """";
		КоманднаяСтрока = """" + JavaSDK + "bin\keytool.exe"" -genkeypair -v " +
			" -keystore """ + ФайлКлюча + """" +
			" -alias " + ПсевдонимКлюча +
			" -storepass " + ПарольКлюча +
			" -keypass " + ПарольКлюча +
			" -keyalg RSA" +
			" -keysize 2048" +
			" -validity 10000" +
			" -dname " + dname;
		ЗапуститьПриложение(КоманднаяСтрока, КаталогВременныхФайлов(), Истина, КодВозврата);
		Если КодВозврата <> 0 Тогда
			Предупреждение(НСтр("ru='Выполнение операции завершено с ошибками: ';en='Operation completed with errors: '", "ru") + КодВозврата);
		КонецЕсли;
	КонецЕсли;
	ПодключитьОбработчикОжидания("ВернутьФокус", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ВернутьФокус()
	
	ОкнаПриложения = ПолучитьОкна();
	Для каждого ОкноПриложения Из ОкнаПриложения Цикл
		Если ОкноПриложения = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ТекущаяФорма = ОкноПриложения.ПолучитьСодержимое();
		Если ТипЗнч(ТекущаяФорма) = Тип("УправляемаяФорма") Тогда
			Если ТекущаяФорма.Заголовок = Заголовок Тогда
				ОкноПриложения.Активизировать();
				Прервать;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Завершение(Команда)
	
	Если НЕ ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	Результат = Новый Структура;
	Результат.Вставить("AndroidSDK", AndroidSDK);
	Результат.Вставить("JavaSDK", JavaSDK);
	Результат.Вставить("ФайлКлюча", ФайлКлюча);
	Результат.Вставить("ПсевдонимКлюча", ПсевдонимКлюча);
	Результат.Вставить("ПарольКлюча", ПарольКлюча);
	Результат.Вставить("РезультатДляAndroid", РезультатДляAndroid);
	Результат.Вставить("РезультатДляiOS", РезультатДляiOS);
	Результат.Вставить("МобильнаяПлатформа", МобильнаяПлатформа);
	Закрыть(Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура МобильнаяПлатформаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Файл = Новый Файл(МобильнаяПлатформа+"\aux");
	ВыборКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ВыборКаталога.Заголовок = НСтр("ru='Выберите каталог размещения файлов мобильной платформы';en='Select mobile platform installation directory'", "ru");
	ВыборКаталога.Каталог = Файл.Путь;
	Пока Истина Цикл
		ЕстьОшибки = Ложь;
		Если ВыборКаталога.Выбрать() Тогда
			Если НЕ ФайлСуществует(ВыборКаталога.Каталог + "\Android\prjandroid.zip") Тогда
				Предупреждение(НСтр("ru='Отсутствует файл с 1С:Предприятием для ОС Android (prjandroid.zip)';en='File containing 1C:Enterprise for Android OS (prjandroid.zip) not found'", "ru"));
				ЕстьОшибки = Истина;
			КонецЕсли;
			Если НЕ ФайлСуществует(ВыборКаталога.Каталог + "\IOS\prjios.zip") Тогда
				Предупреждение(НСтр("ru='Отсутствует файл с 1С:Предприятием для ОС iOS (prjios.zip)';en='File containing 1C:Enterprise for iOS (prjios.zip) not found'", "ru"));
				ЕстьОшибки = Истина;
			КонецЕсли;
			Если ЕстьОшибки Тогда
				Продолжить;
			Иначе
				МобильнаяПлатформа = ВыборКаталога.Каталог + "\";
				Прервать;
			КонецЕсли;
		Иначе
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатДляAndroidНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьКаталог(НСтр("ru='Выберите каталог размещения мобильного приложения для Android';en='Select a destination directory for the Android mobile application'", "ru"),
				РезультатДляAndroid,
				Неопределено,
				Неопределено);
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатДляiOSНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ВыбратьКаталог(НСтр("ru='Выберите каталог размещения архива проекта для iOS';en='Select a destination directory for the iOS project package'", "ru"),
				РезультатДляiOS,
				Неопределено,
				Неопределено);
	
КонецПроцедуры
