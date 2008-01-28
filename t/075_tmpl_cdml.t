; use strict; use warnings
; use Test::More tests => 16

; BEGIN
    { use_ok('HO::Tmpl::Markup::CDML','Cdml')
    }
    
; is("".Cdml->current("foundcount"),'[FMP-CurrentFoundCount]')
; is("".Cdml->current("recid"),'[FMP-CurrentRecID]')
; is("".Cdml->current("recpos"),'[FMP-CurrentRecordNumber]')
; is("".Cdml->current("recordcount"),'[FMP-CurrentRecordCount]')
; is("".Cdml->current("skip"),'[FMP-CurrentSkip]')
; is("".Cdml->current("action"),'[FMP-CurrentAction]')



; is("".Cdml->token,'[FMP-CurrentToken: Raw]')
; is("".Cdml->token(id => 1),'[FMP-CurrentToken: 1, Raw]')
; is("".Cdml->token(id => 2,encode => 'HTML'),'[FMP-CurrentToken: 2, HTML]')

; is("".Cdml->recordset(),'[FMP-Record][/FMP-Record]')
; is("".Cdml->recordset("Need For Speed"),'[FMP-Record]Need For Speed[/FMP-Record]')

; is("".Cdml->portal({name => 'RechnungsNr'})
    ,'[FMP-Portal: RechnungsNr][/FMP-Portal]')

; is("".Cdml->portal({name => 'RechnungsNr'},'123')
    ,'[FMP-Portal: RechnungsNr]123[/FMP-Portal]')
    
; is("".Cdml->field(name => 'fld'),'[FMP-Field: fld, Raw]')
; is("".Cdml->field(name => 'fld', encode => 'HTML'),'[FMP-Field: fld, HTML]')