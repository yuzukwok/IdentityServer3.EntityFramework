﻿CREATE TABLE [dbo].[Scopes] (
    [Id] [int] NOT NULL IDENTITY,
    [Enabled] [bit] NOT NULL,
    [Name] [nvarchar](200) NOT NULL,
    [DisplayName] [nvarchar](200),
    [Description] [nvarchar](1000),
    [Required] [bit] NOT NULL,
    [Emphasize] [bit] NOT NULL,
    [Type] [int] NOT NULL,
    [IncludeAllClaimsForUser] [bit] NOT NULL,
    [ClaimsRule] [nvarchar](200),
    [ShowInDiscoveryDocument] [bit] NOT NULL,
    CONSTRAINT [PK_dbo.Scopes] PRIMARY KEY ([Id])
)
CREATE TABLE [dbo].[ScopeClaims] (
    [Id] [int] NOT NULL IDENTITY,
    [Name] [nvarchar](200) NOT NULL,
    [Description] [nvarchar](1000),
    [AlwaysIncludeInIdToken] [bit] NOT NULL,
    [Scope_Id] [int] NOT NULL,
    CONSTRAINT [PK_dbo.ScopeClaims] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_Scope_Id] ON [dbo].[ScopeClaims]([Scope_Id])
ALTER TABLE [dbo].[ScopeClaims] ADD CONSTRAINT [FK_dbo.ScopeClaims_dbo.Scopes_Scope_Id] FOREIGN KEY ([Scope_Id]) REFERENCES [dbo].[Scopes] ([Id]) ON DELETE CASCADE

CREATE TABLE [dbo].[ScopeSecrets] (
    [Id] [int] NOT NULL IDENTITY,
    [Description] [nvarchar](1000),
    [Expiration] [datetimeoffset](7),
    [Type] [nvarchar](250),
    [Value] [nvarchar](250) NOT NULL,
    [Scope_Id] [int] NOT NULL,
    CONSTRAINT [PK_dbo.ScopeSecrets] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_Scope_Id] ON [dbo].[ScopeSecrets]([Scope_Id])
ALTER TABLE [dbo].[ScopeSecrets] ADD CONSTRAINT [FK_dbo.ScopeSecrets_dbo.Scopes_Scope_Id] FOREIGN KEY ([Scope_Id]) REFERENCES [dbo].[Scopes] ([Id]) ON DELETE CASCADE

ALTER TABLE [dbo].[Scopes] ADD [AllowUnrestrictedIntrospection] [bit] NOT NULL DEFAULT 0


/* if you want to use EF migrations then maybe don't use these files */
/*
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)

INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201502141840088_InitialCreate', N'SelfHost.Migrations.ScopeConfiguration.Configuration',  0x1F8B0800000000000400ED5A5F6FDB36107F1FB0EF20E871482D2779D902BB456A2783B1E60FE2B4D85B404B679B2845AA2495DA1BF6C9F6B08FB4AFB0D37F89B26C5976D261180A041575F7E3DDF1EE7877F2DF7FFE3578B7F299F50C5251C187F669AF6F5BC05DE151BE18DAA19EBFF9D17EF7F6FBEF06579EBFB23E6574E7111D727235B4975A07178EA3DC25F844F57CEA4AA1C45CF75CE13BC413CE59BFFF93737AEA0042D88865598387906BEA43FC808F23C15D087448D88DF080A9741DDF4C6354EB96F8A002E2C2D07E5C52FE5983AB4309BD890708A4D75390A843EF2A7EB89648FD55C8CFB675C9284111A7C0E6B64538179A6854E0E2A382A996822FA6012E10F6B80E00E9E684294815BB28C8DBEAD83F8B74740AC60CCA0D9516FE9E80A7E7A9D11C93BD93E9EDDCA868D6C45091D6B169D142AE08507373A78B119311D55E664F9E29A85E8C7A626DE13D37994F7227EBF7E27F27D6286411E79043A8256127D67D3863D4FD05D68FE233F0210F192B6B87FAE1BBCA022EDD4B9445EAF503CC539D279E6D39553EC764CCD94A3C8941265C9F9FD9D62D6E4E660C72E729196FAA85849F8183241ABC7BA235481E612416A8ED6EEC75C523E07CC3F74230207CC396DB61A2BF19063A3D06B66DDD90D507E00BBD1CDAE822B6754D57E0652B29EA474E310F20939621ECBDEB98AA8091F59136DFB1172857D220098DC6BD4EFB47D9EC01BE84541E7E2C577EB0248AFE06870245DCBB9C723BC284BB2CF4E092B11123D457D742628294870A96803D84ECE53D60BA145F271C7DCE159854D663E1863E06D9DE1ADC9267BA8883D7DC20CA648942B6F5002CA6514B1A24974B92E99E2A54D752F80F8265CCE5974F53114A37328B68A278247201BA2AE0C029F2F6EE6C1E03BD4C4A8FA1FFCFEB1DF3FA374AC8AF99242FD957B256695E99F089179FE891C3F11881988559732066A1DA26102F95122E8D452A0B5A11A7AAE115F7AC9D492239AC5C3B3C308C1C1A60ACA00C7866B61913777C0C0C3458976E526E8E887289573730EAE1B51728379621509A69AA52FD609AAC649C7AF2C20E40138A1155C96082CFE9229431CF7816D1C04A6F4869785BA5594DA5FE692A9564265D4647CF284EB16A5FA7057BE65D9B315293184025131868558F2DD135BAB579E66D3C2957A43081B30F4EE600264E26B7E95D557D3704507EEC45C7E7242D5FD61A3A0DBDE1E086040166AF52AF98AE58D3A4511CBD99EEDF28F90986E3AA0DFD522E6DBE135E046401C65BDC1A25BDA652E931D16446A2CC36F2FC1AD936276FF0C06CE78A1FD78F3073C98C3CFA7F5A2DEE71E927D160A0178646C2455465C56600D327EA7C713B4F18911BEEDE9160A1CF9BEEEF6DDC79975486C817DBE324B772192459698F506979CA4095177BE0956FEC0A5EF9457BBCA273298315AB7BD8BCE85D2A562F96DB6325ED4B192659698FD0D8BE549CAA89A8FD3EE57EA60C5D5E6F8FD6D8B294A11B89EAFB0C1C232CCDACE0D4D242AD16A82699F629A8F14A3A621E4A6ED48EC9A881F96532D21132C99123BFA91C2F4337D1BCBEA755AB860DEE562D960EF0A92A507BCF898AA44D1DC9A6A2AB6EBE562E97E06D72BCB868CFB8BB089656711D05DB4F24B306AC1F78AD1434497277CB4B42A3F41BA465D8EE6F07B5BA2C21B12D94FD997A714DB6561AFC5E44D09B7EC1CB82C6F93623B8219CCE41E9644281BDFAE999F195E1DF33F17794F2589BB1FFABCF586864D29D53947D07AAD571F98CEA8346E5FC99487749647D3673F824BC0D76C7C1F746E864AAB31FB639E7EE62CFDA8CBB0B4879BE1D3BCE71A7DB5D44AA4FB68F75A23B06D9BB85ED3223FE6FC4FFCB04EF0B46D8F6216917BF2C8A86929D6BD3B209F76035B47F8F992EACC9AF4F19DF897527F192BBB0FAD61F1DFDECE011E8B79D77A673BB2E13CEE8670D300719B92F6158CE282DB1A0A955C7F7927297068455B4AE57636D822E5229C733DF8C21001E45535DC136BB6DAB407368C3BCBB0CB0E714B83E476B31986D1EEB26D5DED0F666028F3871EDCD73D02D23DF1D13DFC63D1A66A4AF3812AECF6D778F7F2B2A9B5DD18BCC7BEBC53CBA55E9E742E8D68A2E0A88E8C7431CDC8A43E534133E1799671B126524460ABD014D3CF4B64BA9E99CB81A5FBBA054FC9DEC1361615CD5CCC09BF0BB5007A14695C19FB1CA47BF283EB6ED1F0FB5AB320FEEE23B461D43051493A20A70C7DF879479B9DCD71BB27803441478E9D51C9DA58EAEE8C53A47BA15BC25506ABE3C5F3C828FC5B00675C7A7E419BAC886C5DB075810779DF564CD20BB0FA26AF6C198928524BE4A310A7E7C441FF6FCD5DB7F00805A46B235270000 , N'6.1.2-31219')

INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201504070215165_v2_0_0', N'SelfHost.Migrations.ScopeConfiguration.Configuration',  0x1F8B0800000000000400ED5ADB6EDB46107D2FD07F20F85838A26CBFB48694C091EC42687C81E5047D3356E4485A64B9CBEC2E1DA945BFAC0FFDA4FE42877772298AD4C54E5114018C889C3973D999D99991FEFEF3AFC1BB95CFAC67908A0A3EB44F7B7DDB02EE0A8FF2C5D00EF5FCCD8FF6BBB7DF7F37B8F2FC95F529A33B8FE89093ABA1BDD43AB8701CE52EC127AAE753570A25E6BAE70ADF219E70CEFAFD9F9CD3530710C2462CCB1A3C845C531FE20FF87124B80B810E09BB111E30953EC737D318D5BA253EA880B830B4271E20AF5E4F41A2DAE7BDABF8D3B5448AAF427EB6AD4B4609AA350536B72DC2B9D044A3D2171F154CB5147C310DF001618FEB00906E4E9882D4988B82BCAB5DFDB3C82EA760CCA0DC5069E1EF08787A9E3ACA31D9F772B79D3B125D99382AB23A76277AC815015A6E4ABA18311951B5BA3AF94C41F562A413AB85FE248F9F7E2FFE77628D42A64309430EA196849D58F7E18C51F717583F8ACFC0873C64AC6C049A81EF2A0FF0D1BD44F152AF1F609E9A36F16CCBA9F2392663CE56E249EDE6FAFCCCB66E51389931C863A4E4A3A916127E060E9268F0EE89D62079E1B19A7443D6158F807381EF856040F80691DB61A2BF1906C636E6AC6DDD90D507E00BBD1CDA1809B6754D57E0654F52D48F9C628A23939621EC2C754C55C0C8FA48C25B648172250D920C689475DA3F8AB007F8125279F8B15CF9C19228FA1B1C0A1471B705E57684097759E8C125632346A8AFAE85C43A280F552C017B08D9CB47C07429BE4E38C69C2BB0A8ACC7C20D7D4CB29D2DB825CF741127AF29202A5E8941B6F5002CA6514B1A24774852DC9E2A54D752F80F8265CCE5974F53114A37728B68A278247201BAAAE0C029CA737BD18E818E57B963B8FFCB77F7F2FD8DEAEE6BD6C24BF695AC555A3E267CE2C5277AE4AC3B46BE65D9D49C6F594676C9B74BA5844B6395CA8A56D4A95A78C53DABB5162487955B870786994303CC15D401CFCC3673E28E8F818106EBD24D9AC711512EF1EA0E463BBCEE0AE5CE32144A0B4A55AB1F4C97959C53AF51D8C36B4231A32A854AF0395D8432E619CF221A58E90D950B2FA5B478A9343E4DA392CAA4CBE81819C52956FDEB7460CFA26B3346EA1203A8E40203AD1AB125BAC6B036CFBC4B24E586142E7076C1C902C0C4C9F436A3AB6AEF8604CA8FBD98D99C6468CB863BA761BA1BDC9020C0EA559AF6D227D63419F5466FA6BB8F3D7E82E1B86AC3F4936B9B4BC28B802CC0788BA251D36B2A951E134D6624AA6C23CFAF916D0BF28608CC2457E2B87E84594866E4D1FFB38B6EFBDD9E64808158381709175103159B0E661CD4F9E2219C302237DCB723C1429F37DDD9DBB8F301A80C913FEC8E93DCC46590E4497784CA345306AABCD801AF7C4B57F0CA2FBAE315434919AC78BA83CF8BB1A4E2F5E27177AC643229C3244FBA23344E2695A06A22EA2EA73CAA94A1CBCFBBA3354E2365E846A2BA9C8163A4A559099C5A29A8DDFFD5C2D2BDEC345E4307D69EE4E6DCB3003530BF4C153A42F53872B637B5DD65E8269AD78FAE6A77B021C4AA4DD18E715465EE1E2D5103B469DAD8D450D55DD629CC12BC4DC11637E419F73E8AA51DDA9E8AEDA692D9DFD50FB9D6E699247988E5ED9ED1D60DD216AB7DB35FEBB91212DB42DD9FA917F75B6BA5C1EF4504BDE917BC14685C5733821BC2E91C944EB60F38879F9E19DF07FC7B76F38E521EEBB2A07FF5FD098D5CDABA21D975275ADD78CFA83E68DBCD9F89749744D6F72E872FB3BB60EFB9BBDE089D6C6C76C33657D5FBF8B3B6A6DE07A4BCA28E03E7B80BEA7D54AA2FA78F75A22DBBE87665F759F3FE37F2FF6592F705336CFB02749FB82C9A86929F6B9BB009F76035B47F8F992EACC9AF4F19DF897527F192BBB0FAD61F7BC6D9C1EBCD6FBBCB4C7772FB6C2FA31F1DC01C6414BE84613BA3B4C486A6D611DF4BCA5D1A1056B1BADE8D7549BAC8A41CCF7C33860078944D7503BB48DBD681E6D0867BDB1CB0E386B7BE23EBB0746D5ED926DDDED0F666028F3809EDCD3BCE2DEBDC966D6EA38C86FDE72BAE7BEB3BD9F6D56EC564732A7A915D6EBD99C7B02AFD9807C35AD1450111FDB487835B09A89C66C2E7228B6C43A38CC428A137A08987D17629359D1357E36B17948ABF03FB445818773533F026FC2ED441A8D164F067ACF2855E941FDBE4C70BEBAACE83BBF88E51C73001D5A46802DCF1F721655EAEF7F5862ADE0011255E7A354767A9A32B7AB1CE916E05EF0894BA2FAF178FE06333AC41DDF12979867D74C3E6ED032C88BBCE66B26690F683A8BA7D30A6642189AF528C821F3F620C7BFEEAED3F8992AB9BD3260000 , N'6.1.2-31219')

INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201511200152080_v2_2_0', N'SelfHost.Migrations.ScopeConfiguration.Configuration',  0x1F8B0800000000000400ED5B6D6FDB3610FE3E60FF41D0C721B39C04C5B6C06E913AC960AC79419C16FB563012ED10A54895A4527BC37ED93EEC27ED2FECF46A9192AC17DB493A14058A9A3A3EBC3BDE1D8FC7EBBF7FFF337AB3F4A9F58885249C8DEDC3C1D0B63073B947D8626C876AFEE3CFF69BD7DF7F373AF7FCA5F521A33B8EE860269363FB41A9E0C471A4FB807D24073E7105977CAE062EF71DE471E76838FCC5393C743040D8806559A3DB9029E2E3F807FC9C70E6E24085885E720F53998EC397598C6A5D211FCB00B9786C4F3D0C73D56A8605B07D3C388F7F5D08A0F8C2C527DB3AA504015B334CE7B68518E30A2960FAE4BDC43325385BCC021840F46E1560A09B232A712ACCC99ABCAD5CC3A3482E673D31837243A9B8DF11F0F0385594634EEFA56E3B5724A83251542475AC4ED090CB0390DC5CE964424544D5A8EAE437C17210231D580DF407B9FD0C07F19F036B1252150A3C66385402D103EB26BCA7C4FD0DAFEEF827CCC62CA4B428048801DFB40118BA11B0BC50AB5B3C4F459B7AB6E5E8F31C73623EAD3027959BA9E323DBBA82C5D13DC5B98D147434535CE05F31C30229ECDD20A5B0606B8D955637D63A671170BEE05BCE2946AC62C9CD30D1DF1906D836F8AC6D5DA2E53BCC16EA616C8325D8D60559622F1B4951DF33022E0E93940871E755CF880C285AED68F186B5B0740509120FA85DEB70B893C56EF1E79088EDB7E5DC0F1E90247FE06D81A2D94D46B91961CA5C1A7AF894D20945C497175C401C14DB329680DD8674FF16307BE05FA60C6CCEE510545667DC0D7D70B2CE125CA147B2889DD75C200A5E8940B6758B694C231F48909C214970FBA8515D08EEDF729A4D2E7EFC38E3A17023B5F03A8A3B241658756470865D815523873959258BE9D74D3C6624554C8E9CF519D27CB2C4D2EEEE7889E1BE9D31EDCF98673A1C9E32609FD22F6825D3183765532FDED11D87865D0485CC9BEA8342E692FDFD2DF1DCDD395C82F7CDE3DA7BDC93DAFEF932200215D73A03A6EFE056753D9FCB8AF365436E51151E5EED82C90F8886BB5865BF1EDCEED0DCE0C3E6B9DAC6894FA5E42E89B92AF2AAC5145DC873E6598D5947A2E95C40D036382309C0FD8007303EDB74B36B76862956D83A75936BEA04491779651D831C5E7B86726D190CA55981CED50FA6CA0ACA69ADB36C175BF058CA839E5D6B25233338CA827B3FBD251638E14C2102C14DCBD2389B9345984492B3FB88062FAB4E11B836A407894CBDD2142B392454111D7C6A6DFDBA869D16D3B3A3B51A2335A53640B987572365DA35A00ADA34F0F493BF40579B1E9806D4C6997351D6DA74BAE064C664E2647C9BA6AACBDB4D17B986372AA3D247DB7A696F7598CE6502E5BCB7564816D473975A572C9DA4649995369D9ADAE6E81205011C87855A673A62CD9242E7E4C759F7A29F9F6038AEACA8FDE5DCE62B41BE8316D8F80A4B03A7174448052905BA47D1813BF1FC12D9A60052E394D9CA5A8C286F62E6A41979F4EF2C9FDB9CC326D1C5405C2B17081751F920161D9B86509E1797A01145A222AD9C701AFAAC2E35DD343B2FFF1521F2C1F638C915AF08928CB447D06A794520ED4307BC620AACE1153FB4C75B97E48A60EBD10E3A5F17E534ADAF87DB6325B973112619698F505B97D38CAA8EA8FD3AC5425D11BA38DE1EADB6165784AE252AAF33720CB7342381530A05A5EC4A0F2CEDC34EEDB9BC65EC49B2929E01A866F27EA2D00EA2C78EBDBDAE9E5384AEA37959D6559FE86C695E69AADAD3BEEA66EFC7C0766D1EC5928716C30BE34F19C4D3EA4611221D7A7A63D453D50A8BD4AF2C1DAD4E9FDC3E7445F9785545A6EABA5356592B934CF0AA0C33BE7B67B3FB3096DE177A32D68D25F3B2B1CD26E7F7995EBB9CCFEE104136ABD3B8C8BDA08D366E862F64A74BB74B93240F26F92DD3B84D8ED29B5D733B4DE9AA9790D816F0FE48BCF89AB7920AFB83886030FB0CB92889D3B98CE0123132C75225B57DFB6878786434E1BC9C8618474A8FB6E98A79F2D70912A9B4F1FDA16B2382DE66724FD4562D26EC1109F70189F23BE2F61D246DB07B368C544227AF30DDB0CDFE903EFA2CF586F40129BEDDC486B3DBAE903E2C953B4276B5A30D0D20CDCCF6695BF87FF8FF7E9C778F1EB6F941BF8F5DAEB386829E4B8F1B53E6E1E5D8FE339E74624D7FFF98CD3BB0AE051C7227D6D0FA6BA7765695487DB586B64F9B283F747BC074D43ECCD387EE1B815D923426FFD415BD184AAB5DE455678EB557EF36A05F8B256FFD66FDBC4FADE983619F2769000307C422F20F442131974A406A5EBAC5DF08C25C1220AA495DBE57B4F1EA48A41CCFFC728603CC22772D0BD866B54D97A91CDA506F9302F6F86CFFBC76933D0FF77A94FF3A2CA7B6ACF8CCA653DDB9507E9FACA9CCEA5D4075AD08C99517CE957B0E9B9C44C5EA17E60D6D0A0D5D0AB56BD43CC66F686368EA62A85DAAEE9DFB09FB1CCA8FEFCD8FF89A7ACD82E3CB6D62E823AABEC1A5AADB5E1A14CAA522F0D7C2FFCF828021C9620D11FD6F2D865DCD53739A299BF32C64181C6524465A73891582840E9D0A45E6C855F0D9C552C69D82712215DD99EFB13765D7A10A42052263FF9E6ACD9851E0D9B47EDC85A1F33CBA8EB355B90B11804D12E5A4D7EC6D48A897F37D519159D54044112DCDC7A3BD54515EBE58E548579CB5044AD59707E23BEC0714C0E4359BA147DC87B7F712BFC30BE4AEB28A5F3D48F346E86A1F9D11B410C89729C67A3EFC041BF6FCE5EBFF00066D5AA3A6380000 , N'6.1.3-40302')

INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201512191738380_v2_3_0', N'SelfHost.Migrations.ScopeConfiguration.Configuration',  0x1F8B0800000000000400ED5B5F6FDB36107F1FB0EF20E871C82C2741B12DB05BA44E32186BFE204E8ABD15B4443B44295225A9C4DEB04FB6877DA47D859DFE5AA2248B96ED241D8A02454D1D7F773CDE1D8FC7EBBF7FFF3378B7F0A9F58885249C0DEDC35EDFB63073B947D87C68876AF6E3CFF6BBB7DF7F3738F7FC85F531A33B8EE860269343FB41A9E0C471A4FB807D247B3E7105977CA67A2EF71DE471E7A8DFFFC5393C743040D880655983DB9029E2E3F807FC1C71E6E24085885E720F53998EC397498C6A5D211FCB00B978688F3D0C73D5728205887DDC3B8F7F5D08A078E2E2B36D9D528240AC09A633DB428C718514087D722FF14409CEE693000610BD5B0618E866884A9C2EE664456EBAAEFE51B42E673531837243A9B8BF21E0E171AA28479FDE49DD76AE485065A2A868D5B13A41432E0F60E53AA79311151155ABAA93DF04CB5E8C7460B5D01FE4F6D3EFC57F0EAC51485528F090E15009440FAC9B704A89FB1B5EDEF1CF980D5948697111B00CF8561A80A11B01EC855ADEE259BAB4B1675B4E799EA34FCCA715E6A4EB66EAF8C8B6AE80399A529CDB48414713C505FE15332C90C2DE0D520A0BB6D25885BBC6EB9C45C039C3F79C538C580DCBF530D1DF1906D836F8AC6D5DA2C507CCE6EA61688325D8D60559602F1B4951EF19011787494A847863AE674406142D77C4BC851796AE2041E2018DBC0EFB3B61768BBF84446CBF2DE77EF08024F9036F0B14CD6E33CAF50863E6D2D0C3A7948E2822BEBCE002E2A0D856B004EC36A4FBB780C9037F1A33B039974350599E7137F4C1C9B65D0168843FDD33812508EE820F837E219006D82DDA9A31FA157A24F33834E8E247A13151976DDD621AD3C80712242754123A3F95A82E04F76F39CD26173F7E9AF050B891D27913C51D1273AC361470825D8155AB843959AD88E9D77532662475420E9CD509D57E6EC5ABDDDDE115C37D3BC1CC4FB0173A7A9EF33838A54F6829D3083A66632FDED11D87865D0485CC9B9A8342E692DDFD2DF1DCDD395C82F7CDE3CC3DEE596DFF7C1110818ABCCE40E83BB8B35DCF66B2E67C5993B9D4858737BB10F223A2E12EB8ECD783CD0ECD353EAC9FAB264E7C2A2577492C5551D6524C292FF29C79566BD691683A5F20681B9C9104E07E2003189FADBBD9353BC3142B6C9DBAC9257884A48BBCAA8E611D9EB940B9B63481D2ACA02CD50FBACA0ACA31D659B68B063256F2A017D75AC5C83489B2E0DE4D6F89058E38538840702B65699CCDC83C4C22C9D934A2C18BBA53042E25E9412253AFD497951C12AA880E3EB5B2FEB2861D83E9D9D15A8F919A920950EEE1F548997635A8823635BCF2C95FA06B4C0F74033271E67C292B6D3A9BE064C6A4E36472EBA65A5EEF66BAC835BC5619B53E6AEAA59DD5A13B970E94CB6EAC902CA8E72EB5AA873A4941342B9C3A0D95D3C1250A02380E0B95D474C49A2465D4D18F93CD4B8A7E82E1B8B2A6B2984B9B73827C07CDB1F6155883A41744480529059AA2E8C01D797E856C5D006970CA8C73294654373173D28C3CFA7796CFADCF6193E8A221AE940B84F3A838112F1DEB86509D1717B81145A226AD1C711AFAAC29355D373B2F2E1621F241739CE48A57044946CC114A95C22250E9C30678C514B88457FC608EB72AF815C156A31BE87C55F22B697D356C8E95E4CE459864C41CA1B1EA5732AA2622733EC5326011BA386E8ED658E92B42371299F3692BFD15D9B5D156B90E1C2D18E8F1C7A904A04A4E570E67E6C1AE311BD832E225B950C7B0D730793FB16F07316BC731A6A98A54B6B27A9AD7655DCDE9D596E69526C81DEDAB69F67E0C6CD7E6512CB4944E8EC2F8731E1D694DA508910E3DBF319613E41A8B2C5F9436B4BAF264F3D015DD02EAEA407597ACAACA8C4C32C1AB33CCF8C69FCDEE22587A4BE928D86622E9579C6D3639BF4575DAE57CF6061164BD3AB5EBE32BDA68ED3EFA4A76BA72A7D549F26092DF6DB53BEC20BD4FB6B708552E9809896D81EC8FC48B2F974BA9B0DF8B087A932F9001933889CC082E112333C8F9921705FBA87F78A43516BD9E261F474A8F9A74FA3CFB9B088954DAFAEAB1697345B975664AD4566D33EC1109F70189EAEBE5F65D3126D81D9B606AA193B79FCDB0F59E972EFAACF4BB740129BE18C586B3DB4E972E2255BB5C76B5A32D4D2D5D84356B686947EED286F1FF882CFB090B7BF4DDF50D0A5D8C68958F14F45C79AC19330F2F86F69FF1A4136BFCFBA76CDE81752DE0F83CB1FAD65F3BB5B3BA14EDAB35B47DDA44F5E1DE03A1A3666B9E3EDCDF08EC92A48DFBA74DD18B41BADE45DE6C2C71E915DF04F46BB1E4ADDFE05FF6E9387D00EDF2C40E60E0805844FE8128A4FC702641D25FA90FDC08C25C12205A5A75F5C662E2D5D192723CFDCB190E308BDCB5BA40136EEBAE6939B4A6DE3605ECB10DE165ED267BEEEED464F075584E63C1F2854DA7BE13A3FADEDA50F32D773535B5562497693857A61C3639898AF52FE66BDA2E5ABA2E1A79343417AC69CB68EBCA6864D5F46EFF8C7D1BD56682F6A684927AF552E6EB6DCAE8B2D4F20657EA797B69B8A816A1C05F0BFF9B0D028624F31544F47FDB5872075B8166346336E359C8D024CA48B4B4E6122B04091D3A158ACC90ABE0B38BA58C3B1FE3442ABA8D4FA3CBDF75A88250C192B13FA5A5E6D228F0ACE31F779594651E5CC7D9AADCC512404C12E5A4D7EC7D48A897CB7D519359354044112DCDC7A3BD54515E3E5FE648579C1902A5EACB03F11DF6030A60F29A4DD023EE22DBBDC41FF01CB9CBAC96D80CD2BE1165B50FCE089A0BE4CB1463351F7E820D7BFEE2ED7FCE96484ED4390000 , N'6.1.3-40302')

INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201601182228505_v2_4_0', N'SelfHost.Migrations.ScopeConfiguration.Configuration',  0x1F8B0800000000000400ED5B5F6FDB36107F1FB0EF20E871C82C2741B12DB05BA44E32186BFE204E8ABD15B4443B44295225A9C4DEB04FB6877DA47D859DFE5AA2248B96ED241D8A02454D1D7F773CDE1D8FC7EBBF7FFF3378B7F0A9F58885249C0DEDC35EDFB63073B947D87C68876AF6E3CFF6BBB7DF7F3738F7FC85F531A33B8EE860269343FB41A9E0C471A4FB807D247B3E7105977CA67A2EF71DE471E7A8DFFFC5393C743040D880655983DB9029E2E3F807FC1C71E6E24085885E720F53998EC397498C6A5D211FCB00B978688F3D0C73D5728205887DDC3B8F7F5D08A078E2E2B36D9D528240AC09A633DB428C718514087D722FF14409CEE693000610BD5B0618E866884A9C2EE664456EBAAEFE51B42E673531837243A9B8BF21E0E171AA28479FDE49DD76AE485065A2A868D5B13A41432E0F60E53AA79311151155ABAA93DF04CB5E8C7460B5D01FE4F6D3EFC57F0EAC51485528F090E15009440FAC9B704A89FB1B5EDEF1CF980D5948697111B00CF8561A80A11B01EC855ADEE259BAB4B1675B4E799EA34FCCA715E6A4EB66EAF8C8B6AE80399A529CDB48414713C505FE15332C90C2DE0D520A0BB6D25885BBC6EB9C45C039C3F79C538C580DCBF530D1DF1906D836F8AC6D5DA2C507CCE6EA61688325D8D60559602F1B4951EF19011787494A847863AE674406142D77C4BC851796AE2041E2018DBC0EFB3B61768BBF84446CBF2DE77EF08024F9036F0B14CD6E33CAF50863E6D2D0C3A7948E2822BEBCE002E2A0D856B004EC36A4FBB780C9037F1A33B039974350599E7137F4C1C9B65D0168843FDD33812508EE820F837E219006D82DDA9A31FA157A24F33834E8E247A13151976DDD621AD3C80712242754123A3F95A82E04F76F39CD26173F7E9AF050B891D27913C51D1273AC361470825D8155AB843959AD88E9D77532662475420E9CD509D57E6EC5ABDDDDE115C37D3BC1CC4FB0173A7A9EF33838A54F6829D3083A66632FDED11D87865D0485CC9B9A8342E692DDFD2DF1DCDD395C82F7CDE3CC3DEE596DFF7C1110818ABCCE40E83BB8B35DCF66B2E67C5993B9D4858737BB10F223A2E12EB8ECD783CD0ECD353EAC9FAB264E7C2A2577492C5551D6524C292FF29C79566BD691683A5F20681B9C9104E07E2003189FADBBD9353BC3142B6C9DBAC9257884A48BBCAA8E611D9EB940B9B63481D2ACA02CD50FBACA0ACA31D659B68B063256F2A017D75AC5C83489B2E0DE4D6F89058E38538840702B65699CCDC83C4C22C9D934A2C18BBA53042E25E9412253AFD497951C12AA880E3EB5B2FEB2861D83E9D9D15A8F919A920950EEE1F548997635A8823635BCF2C95FA06B4C0F74033271E67C292B6D3A9BE064C6A4E36472EBA65A5EEF66BAC835BC5619B53E6AEAA59DD5A13B970E94CB6EAC902CA8E72EB5AA873A4941342B9C3A0D95D3C1250A02380E0B95D474C49A2465D4D18F93CD4B8A7E82E1B8B2A6B2984B9B73827C07CDB1F6155883A41744480529059AA2E8C01D797E856C5D006970CA8C73294654373173D28C3CFA7796CFADCF6193E8A221AE940B84F3A838112F1DEB86509D1717B81145A226AD1C711AFAAC29355D373B2F2E1621F241739CE48A57044946CC114A95C22250E9C30678C514B88457FC608EB72AF815C156A31BE87C55F22B697D356C8E95E4CE459864C41CA1B1EA5732AA2622733EC5326011BA386E8ED658E92B42371299F3692BFD15D9B5D156B90E1C2D18E8F1C7A904A04A4E570E67E6C1AE311BD832E225B950C7B0D730793FB16F07316BC731A6A98A54B6B27A9AD7655DCDE9D596E69526C81DEDAB69F67E0C6CD7E6512CB4944E8EC2F8731E1D694DA508910E3DBF319613E41A8B2C5F9436B4BAF264F3D015DD02EAEA407597ACAACA8C4C32C1AB33CCF8C69FCDEE22587A4BE928D86622E9579C6D3639BF4575DAE57CF6061164BD3AB5EBE32BDA68ED3EFA4A76BA72A7D549F26092DF6DB53BEC20BD4FB6B708552E9809896D81EC8FC48B2F974BA9B0DF8B087A932F9001933889CC082E112333C8F9921705FBA87F78A43516BD9E261F474A8F9A74FA3CFB9B088954DAFAEAB1697345B975664AD4566D33EC1109F70189EAEBE5F65D3126D81D9B606AA193B79FCDB0F59E972EFAACF4BB740129BE18C586B3DB4E972E2255BB5C76B5A32D4D2D5D84356B686947EED286F1FF882CFB090B7BF4DDF50D0A5D8C68958F14F45C79AC19330F2F86F69FF1A4136BFCFBA76CDE81752DE0F83CB1FAD65F3BB5B3BA14EDAB35B47DDA44F5E1DE03A1A3666B9E3EDCDF08EC92A48DFBA74DD18B41BADE45DE6C2C71E915DF04F46BB1E4ADDFE05FF6E9387D00EDF2C40E60E0805844FE8128A4FC702641D25FA90FDC08C25C12205A5A75F5C662E2D5D192723CFDCB190E308BDCB5BA40136EEBAE6939B4A6DE3605ECB10DE165ED267BEEEED464F075584E63C1F2854DA7BE13A3FADEDA50F32D773535B5562497693857A61C3639898AF52FE66BDA2E5ABA2E1A79343417AC69CB68EBCA6864D5F46EFF8C7D1BD56682F6A684927AF552E6EB6DCAE8B2D4F20657EA797B69B8A816A1C05F0BFF9B0D028624F31544F47FDB5872075B8166346336E359C8D024CA48B4B4E6122B04091D3A158ACC90ABE0B38BA58C3B1FE3442ABA8D4FA3CBDF75A88250C192B13FA5A5E6D228F0ACE31F779594651E5CC7D9AADCC512404C12E5A4D7EC7D48A897CB7D519359354044112DCDC7A3BD54515E3E5FE648579C1902A5EACB03F11DF6030A60F29A4DD023EE22DBBDC41FF01CB9CBAC96D80CD2BE1165B50FCE089A0BE4CB1463351F7E820D7BFEE2ED7FCE96484ED4390000 , N'6.1.3-40302')

INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201603311623248_v2_5_0', N'SelfHost.Migrations.ScopeConfiguration.Configuration',  0x1F8B0800000000000400ED5B5F6FDB36107F1FB0EF20E871C82C2741B12DB05BA44E32186BFE204E8ABD15B4443B44295225A9C4DEB04FB6877DA47D859DFE5AA2248B96ED241D8A02454D1D7F773CDE1D8FC7EBBF7FFF3378B7F0A9F58885249C0DEDC35EDFB63073B947D87C68876AF6E3CFF6BBB7DF7F3738F7FC85F531A33B8EE860269343FB41A9E0C471A4FB807D247B3E7105977CA67A2EF71DE471E7A8DFFFC5393C743040D880655983DB9029E2E3F807FC1C71E6E24085885E720F53998EC397498C6A5D211FCB00B978688F3D0C73D5728205887DDC3B8F7F5D08A078E2E2B36D9D528240AC09A633DB428C718514087D722FF14409CEE693000610BD5B0618E866884A9C2EE664456EBAAEFE51B42E673531837243A9B8BF21E0E171AA28479FDE49DD76AE485065A2A868D5B13A41432E0F60E53AA79311151155ABAA93DF04CB5E8C7460B5D01FE4F6D3EFC57F0EAC51485528F090E15009440FAC9B704A89FB1B5EDEF1CF980D5948697111B00CF8561A80A11B01EC855ADEE259BAB4B1675B4E799EA34FCCA715E6A4EB66EAF8C8B6AE80399A529CDB48414713C505FE15332C90C2DE0D520A0BB6D25885BBC6EB9C45C039C3F79C538C580DCBF530D1DF1906D836F8AC6D5DA2C507CCE6EA61688325D8D60559602F1B4951EF19011787494A847863AE674406142D77C4BC851796AE2041E2018DBC0EFB3B61768BBF84446CBF2DE77EF08024F9036F0B14CD6E33CAF50863E6D2D0C3A7948E2822BEBCE002E2A0D856B004EC36A4FBB780C9037F1A33B039974350599E7137F4C1C9B65D0168843FDD33812508EE820F837E219006D82DDA9A31FA157A24F33834E8E247A13151976DDD621AD3C80712242754123A3F95A82E04F76F39CD26173F7E9AF050B891D27913C51D1273AC361470825D8155AB843959AD88E9D77532662475420E9CD509D57E6EC5ABDDDDE115C37D3BC1CC4FB0173A7A9EF33838A54F6829D3083A66632FDED11D87865D0485CC9B9A8342E692DDFD2DF1DCDD395C82F7CDE3CC3DEE596DFF7C1110818ABCCE40E83BB8B35DCF66B2E67C5993B9D4858737BB10F223A2E12EB8ECD783CD0ECD353EAC9FAB264E7C2A2577492C5551D6524C292FF29C79566BD691683A5F20681B9C9104E07E2003189FADBBD9353BC3142B6C9DBAC9257884A48BBCAA8E611D9EB940B9B63481D2ACA02CD50FBACA0ACA31D659B68B063256F2A017D75AC5C83489B2E0DE4D6F89058E38538840702B65699CCDC83C4C22C9D934A2C18BBA53042E25E9412253AFD497951C12AA880E3EB5B2FEB2861D83E9D9D15A8F919A920950EEE1F548997635A8823635BCF2C95FA06B4C0F74033271E67C292B6D3A9BE064C6A4E36472EBA65A5EEF66BAC835BC5619B53E6AEAA59DD5A13B970E94CB6EAC902CA8E72EB5AA873A4941342B9C3A0D95D3C1250A02380E0B95D474C49A2465D4D18F93CD4B8A7E82E1B8B2A6B2984B9B73827C07CDB1F6155883A41744480529059AA2E8C01D797E856C5D006970CA8C73294654373173D28C3CFA7796CFADCF6193E8A221AE940B84F3A838112F1DEB86509D1717B81145A226AD1C711AFAAC29355D373B2F2E1621F241739CE48A57044946CC114A95C22250E9C30678C514B88457FC608EB72AF815C156A31BE87C55F22B697D356C8E95E4CE459864C41CA1B1EA5732AA2622733EC5326011BA386E8ED658E92B42371299F3692BFD15D9B5D156B90E1C2D18E8F1C7A904A04A4E570E67E6C1AE311BD832E225B950C7B0D730793FB16F07316BC731A6A98A54B6B27A9AD7655DCDE9D596E69526C81DEDAB69F67E0C6CD7E6512CB4944E8EC2F8731E1D694DA508910E3DBF319613E41A8B2C5F9436B4BAF264F3D015DD02EAEA407597ACAACA8C4C32C1AB33CCF8C69FCDEE22587A4BE928D86622E9579C6D3639BF4575DAE57CF6061164BD3AB5EBE32BDA68ED3EFA4A76BA72A7D549F26092DF6DB53BEC20BD4FB6B708552E9809896D81EC8FC48B2F974BA9B0DF8B087A932F9001933889CC082E112333C8F9921705FBA87F78A43516BD9E261F474A8F9A74FA3CFB9B088954DAFAEAB1697345B975664AD4566D33EC1109F70189EAEBE5F65D3126D81D9B606AA193B79FCDB0F59E972EFAACF4BB740129BE18C586B3DB4E972E2255BB5C76B5A32D4D2D5D84356B686947EED286F1FF882CFB090B7BF4DDF50D0A5D8C68958F14F45C79AC19330F2F86F69FF1A4136BFCFBA76CDE81752DE0F83CB1FAD65F3BB5B3BA14EDAB35B47DDA44F5E1DE03A1A3666B9E3EDCDF08EC92A48DFBA74DD18B41BADE45DE6C2C71E915DF04F46BB1E4ADDFE05FF6E9387D00EDF2C40E60E0805844FE8128A4FC702641D25FA90FDC08C25C12205A5A75F5C662E2D5D192723CFDCB190E308BDCB5BA40136EEBAE6939B4A6DE3605ECB10DE165ED267BEEEED464F075584E63C1F2854DA7BE13A3FADEDA50F32D773535B5562497693857A61C3639898AF52FE66BDA2E5ABA2E1A79343417AC69CB68EBCA6864D5F46EFF8C7D1BD56682F6A684927AF552E6EB6DCAE8B2D4F20657EA797B69B8A816A1C05F0BFF9B0D028624F31544F47FDB5872075B8166346336E359C8D024CA48B4B4E6122B04091D3A158ACC90ABE0B38BA58C3B1FE3442ABA8D4FA3CBDF75A88250C192B13FA5A5E6D228F0ACE31F779594651E5CC7D9AADCC512404C12E5A4D7EC7D48A897CB7D519359354044112DCDC7A3BD54515E3E5FE648579C1902A5EACB03F11DF6030A60F29A4DD023EE22DBBDC41FF01CB9CBAC96D80CD2BE1165B50FCE089A0BE4CB1463351F7E820D7BFEE2ED7FCE96484ED4390000 , N'6.1.3-40302')

*/