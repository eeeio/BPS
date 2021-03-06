﻿
Процедура ПередЗаписью(Отказ)
	//ИспользуетсяЛиВСогласованиях();
КонецПроцедуры

Функция ПолучитьНовыйКлючСтроки() Экспорт 
	НовыйКлючСтроки = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОпределениеЛистаСогласования.КлючСтроки
	|ПОМЕСТИТЬ ВТОпределениеЛистаСогласования
	|ИЗ
	|	&ОпределениеЛистаСогласования КАК ОпределениеЛистаСогласования
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ВТОпределениеЛистаСогласования.КлючСтроки) КАК КлючСтроки
	|ИЗ
	|	ВТОпределениеЛистаСогласования КАК ВТОпределениеЛистаСогласования
	|
	|ИМЕЮЩИЕ
	|	МАКСИМУМ(ВТОпределениеЛистаСогласования.КлючСтроки) ЕСТЬ НЕ NULL ";
	
	Запрос.УстановитьПараметр("ОпределениеЛистаСогласования",ОпределениеЛистаСогласования.Выгрузить());
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		НовыйКлючСтроки = Выборка.КлючСтроки;	
	КонецЦикла;
	Если НовыйКлючСтроки = Неопределено Тогда
		НовыйКлючСтроки = 1;
	Иначе
		НовыйКлючСтроки = НовыйКлючСтроки + 1
	Конецесли;
	Возврат НовыйКлючСтроки;
КонецФункции //ПолучитьНовыйКлючСтроки

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	УпрощеннаяСистемаУведомлений = Истина;
	УведомитьИнициатораОЗавершении = Истина;
	РазрешеноПовторноеСогласование = Ложь;
	
	СтрокаДействия = Действия.Добавить();
	СтрокаДействия.Событие = Перечисления.бпсСобытия.ПередСтартом;
	СтрокаДействия.Действие = Перечисления.бпсДействия.ЗаблокироватьОбъектБД;
	
	СтрокаДействия = Действия.Добавить();
	СтрокаДействия.Событие = Перечисления.бпсСобытия.ПриЗавершенииЕслиНеСогласовано;
	СтрокаДействия.Действие = Перечисления.бпсДействия.РазблокироватьОбъектБД;
КонецПроцедуры

