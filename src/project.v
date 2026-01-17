module Day_12_solver (
    m_tready,
    s_tdata,
    clear,
    clock,
    s_tvalid,
    s_tready,
    m_tvalid,
    m_tlast,
    m_tdata
);

    input m_tready;
    input [7:0] s_tdata;
    input clear;
    input clock;
    input s_tvalid;
    output s_tready;
    output m_tvalid;
    output m_tlast;
    output [7:0] m_tdata;

    wire _59;
    wire _84;
    wire _85;
    wire _86;
    wire _87;
    wire _62;
    wire _63;
    reg _89;
    wire _1;
    reg _60;
    wire _94;
    wire _95;
    wire _96;
    wire _97;
    wire _92;
    wire _93;
    reg _98;
    wire _2;
    reg _91;
    wire _100;
    wire [6:0] _99;
    wire [7:0] _101;
    wire _103;
    wire _104;
    wire _705;
    wire [3:0] _44;
    wire _7;
    wire [3:0] _702;
    wire [3:0] _701;
    wire [3:0] _697;
    wire [3:0] _698;
    wire [3:0] _699;
    wire [3:0] _700;
    wire [3:0] _102;
    wire [3:0] _695;
    wire [3:0] _696;
    wire [3:0] _88;
    wire [3:0] _64;
    wire _691;
    wire _692;
    wire [15:0] _687;
    wire [15:0] _683;
    wire [7:0] _678;
    wire [7:0] _677;
    wire [15:0] _679;
    wire [11:0] _673;
    wire [15:0] _675;
    wire [1:0] _670;
    wire [13:0] _669;
    wire [15:0] _671;
    wire [15:0] _667;
    wire _665;
    wire [15:0] _668;
    wire _664;
    wire [15:0] _672;
    wire _663;
    wire [15:0] _676;
    wire _662;
    wire [15:0] _680;
    wire [4:0] _660;
    wire _661;
    wire [15:0] _682;
    wire [15:0] _684;
    wire [15:0] _685;
    wire [15:0] _686;
    wire _688;
    wire _689;
    wire _123;
    wire _121;
    reg _124;
    wire _8;
    wire [15:0] _448;
    wire [15:0] _449;
    wire _122;
    wire [15:0] _450;
    wire [7:0] _442;
    wire [15:0] _444;
    wire [11:0] _438;
    wire [15:0] _440;
    wire [13:0] _434;
    wire [15:0] _436;
    wire [14:0] _430;
    wire [15:0] _432;
    wire [3:0] _423;
    wire [3:0] _421;
    reg [3:0] _425;
    wire [3:0] _417;
    wire [3:0] _416;
    reg [3:0] _420;
    reg [3:0] _415;
    reg [3:0] _410;
    reg [3:0] _405;
    reg [3:0] _400;
    reg [3:0] _395;
    reg [3:0] _390;
    reg [3:0] _426;
    reg [3:0] _384;
    reg [3:0] _379;
    reg [3:0] _374;
    reg [3:0] _369;
    reg [3:0] _364;
    reg [3:0] _359;
    reg [3:0] _354;
    wire [3:0] _346;
    reg [3:0] _349;
    reg [3:0] _385;
    wire [3:0] _340;
    reg [3:0] _343;
    wire [3:0] _335;
    reg [3:0] _338;
    reg [3:0] _333;
    reg [3:0] _328;
    reg [3:0] _323;
    reg [3:0] _318;
    reg [3:0] _313;
    reg [3:0] _308;
    reg [3:0] _344;
    reg [3:0] _302;
    reg [3:0] _297;
    reg [3:0] _292;
    reg [3:0] _287;
    reg [3:0] _282;
    reg [3:0] _277;
    reg [3:0] _272;
    reg [3:0] _267;
    reg [3:0] _303;
    reg [3:0] _261;
    wire [3:0] _255;
    reg [3:0] _256;
    reg [3:0] _251;
    reg [3:0] _246;
    reg [3:0] _241;
    reg [3:0] _236;
    reg [3:0] _231;
    reg [3:0] _226;
    reg [3:0] _262;
    reg [3:0] _220;
    reg [3:0] _215;
    reg [3:0] _210;
    reg [3:0] _205;
    reg [3:0] _200;
    reg [3:0] _195;
    reg [3:0] _190;
    wire [1:0] _180;
    reg [3:0] _185;
    reg [3:0] _221;
    wire [2:0] _178;
    wire _146;
    reg _148;
    wire _9;
    wire [2:0] _150;
    reg [2:0] _151;
    wire [2:0] _10;
    reg [2:0] _159[0:11];
    wire _152;
    wire [3:0] _153;
    wire [3:0] _156;
    wire [3:0] _157;
    reg [3:0] _158;
    wire [3:0] _11;
    wire [2:0] _160;
    reg [2:0] _161;
    wire [2:0] _12;
    reg [2:0] _179;
    reg [3:0] _427;
    wire [11:0] _177;
    wire [15:0] _428;
    wire _174;
    wire [2:0] _172;
    wire _173;
    wire _175;
    wire [15:0] _429;
    wire _171;
    wire [15:0] _433;
    wire _170;
    wire [15:0] _437;
    wire _169;
    wire [15:0] _441;
    wire [3:0] _167;
    wire _168;
    wire [15:0] _445;
    wire [15:0] _446;
    wire _120;
    wire [15:0] _447;
    reg [15:0] _451;
    wire [15:0] _13;
    reg [15:0] _164[0:15];
    wire [2:0] _117;
    wire [4:0] _106;
    wire [7:0] _118;
    wire [18:0] _65;
    wire _454;
    wire _455;
    wire _456;
    wire gnd;
    wire _452;
    wire _453;
    wire vdd;
    reg _457;
    wire _14;
    wire [15:0] _478;
    wire [2:0] _476;
    wire [2:0] _477;
    wire [18:0] _479;
    wire [7:0] _471;
    wire [7:0] _472;
    wire [15:0] _473;
    wire [18:0] _474;
    wire [7:0] _465;
    wire [15:0] _467;
    wire [18:0] _468;
    wire [18:0] _469;
    wire [18:0] _475;
    wire [18:0] _480;
    wire [18:0] _461;
    wire [18:0] _462;
    reg [18:0] _481;
    wire [18:0] _15;
    reg [18:0] _538[0:11];
    wire [3:0] _112;
    wire _113;
    wire _110;
    wire [3:0] _107;
    wire _108;
    wire _111;
    wire _114;
    wire [3:0] _534;
    wire [3:0] _533;
    wire [3:0] _535;
    wire [2:0] _50;
    wire [2:0] _529;
    wire [2:0] _523;
    wire [2:0] _525;
    wire [2:0] _527;
    wire [2:0] _520;
    wire [3:0] _57;
    wire [3:0] _483;
    wire [3:0] _484;
    wire [3:0] _485;
    wire [3:0] _486;
    wire [3:0] _487;
    reg [3:0] _488;
    wire [3:0] _16;
    reg [3:0] _155;
    wire [2:0] _506;
    wire [2:0] _507;
    wire _83;
    wire [2:0] _499;
    wire [7:0] _491;
    wire [7:0] _492;
    reg [7:0] _494;
    wire [7:0] _17;
    reg [7:0] _78;
    wire [7:0] _80;
    wire _81;
    wire [2:0] _500;
    wire [7:0] _495;
    reg [7:0] _497;
    wire [7:0] _18;
    reg [7:0] _72;
    wire [7:0] _74;
    wire [7:0] _70;
    wire _75;
    wire [2:0] _501;
    wire [2:0] _68;
    wire [2:0] _67;
    wire _69;
    wire [2:0] _502;
    reg [2:0] _508;
    wire [2:0] _19;
    reg [2:0] _116;
    wire _504;
    wire [3:0] _514;
    wire [3:0] _511;
    wire [3:0] _512;
    wire [3:0] _513;
    reg [3:0] _515;
    wire [3:0] _20;
    reg [3:0] _53;
    wire _58;
    wire [2:0] _518;
    wire [2:0] _521;
    reg [2:0] _530;
    wire [2:0] _21;
    reg [2:0] _49;
    wire _51;
    wire [3:0] _536;
    reg [3:0] _537;
    wire [3:0] _22;
    wire [18:0] _539;
    reg [18:0] _540;
    wire [18:0] _23;
    reg [18:0] _66;
    wire [7:0] _76;
    wire [7:0] _119;
    wire [3:0] _543;
    reg [3:0] _544;
    wire [3:0] _24;
    wire [15:0] _165;
    reg [15:0] _166;
    wire [15:0] _656;
    wire _658;
    wire _659;
    wire _690;
    wire _693;
    wire [3:0] _694;
    wire [3:0] _47;
    wire [3:0] _651;
    wire [3:0] _652;
    wire [3:0] _650;
    wire [3:0] _647;
    wire [2:0] _641;
    wire [2:0] _638;
    wire _639;
    wire [2:0] _642;
    wire [3:0] _550;
    wire [3:0] _551;
    wire [3:0] _548;
    reg [3:0] _552;
    wire [3:0] _25;
    reg [3:0] _55;
    wire _144;
    wire [7:0] _560;
    reg [7:0] _562;
    wire [7:0] _563;
    reg [7:0] _556;
    wire [7:0] _557;
    wire [7:0] _558;
    reg [7:0] _564;
    wire [7:0] _26;
    reg [7:0] _138;
    wire [7:0] _570;
    reg [7:0] _572;
    wire [7:0] _573;
    reg [7:0] _566;
    wire [7:0] _567;
    wire [7:0] _568;
    reg [7:0] _574;
    wire [7:0] _27;
    reg [7:0] _136;
    wire [7:0] _580;
    reg [7:0] _582;
    wire [7:0] _583;
    reg [7:0] _576;
    wire [7:0] _577;
    wire [7:0] _578;
    reg [7:0] _584;
    wire [7:0] _28;
    reg [7:0] _134;
    wire [7:0] _590;
    reg [7:0] _592;
    wire [7:0] _593;
    reg [7:0] _586;
    wire [7:0] _587;
    wire [7:0] _588;
    reg [7:0] _594;
    wire [7:0] _29;
    reg [7:0] _132;
    wire [7:0] _600;
    reg [7:0] _602;
    wire [7:0] _603;
    reg [7:0] _596;
    wire [7:0] _597;
    wire [7:0] _598;
    reg [7:0] _604;
    wire [7:0] _30;
    reg [7:0] _130;
    wire [7:0] _610;
    reg [7:0] _612;
    wire [7:0] _613;
    wire [7:0] _32;
    wire [2:0] _553;
    wire [2:0] _554;
    reg [7:0] _606;
    wire [7:0] _607;
    wire [7:0] _608;
    reg [7:0] _614;
    wire [7:0] _33;
    reg [7:0] _128;
    reg [7:0] _139;
    wire _141;
    wire _142;
    wire _145;
    wire [2:0] _643;
    wire [3:0] _545;
    wire _35;
    wire _37;
    wire [3:0] _624;
    wire [3:0] _625;
    wire [3:0] _620;
    wire [3:0] _621;
    wire [3:0] _622;
    reg [3:0] _626;
    wire [3:0] _38;
    reg [3:0] _542;
    wire _546;
    wire [2:0] _637;
    wire _490;
    wire [2:0] _632;
    wire [2:0] _630;
    wire _618;
    wire [2:0] _633;
    wire [2:0] _634;
    wire [2:0] _635;
    wire [2:0] _628;
    reg [2:0] _644;
    wire [2:0] _39;
    reg [2:0] _126;
    wire _616;
    wire [3:0] _648;
    wire [3:0] _649;
    wire _41;
    wire [3:0] _646;
    reg [3:0] _703;
    wire [3:0] _42;
    (* fsm_encoding="one_hot" *)
    reg [3:0] _45;
    wire _704;
    wire _706;
    assign _59 = 1'b0;
    assign _84 = _83 ? vdd : _60;
    assign _85 = _81 ? _60 : _84;
    assign _86 = _75 ? _60 : _85;
    assign _87 = _69 ? _60 : _86;
    assign _62 = _58 ? vdd : _60;
    assign _63 = _51 ? _60 : _62;
    always @* begin
        case (_45)
        4'b0101:
            _89 <= gnd;
        4'b1001:
            _89 <= _63;
        4'b1010:
            _89 <= _87;
        default:
            _89 <= _60;
        endcase
    end
    assign _1 = _89;
    always @(posedge _37) begin
        if (_35)
            _60 <= _59;
        else
            _60 <= _1;
    end
    assign _94 = _83 ? gnd : _91;
    assign _95 = _81 ? _91 : _94;
    assign _96 = _75 ? _91 : _95;
    assign _97 = _69 ? _91 : _96;
    assign _92 = _58 ? vdd : _91;
    assign _93 = _51 ? _91 : _92;
    always @* begin
        case (_45)
        4'b0101:
            _98 <= gnd;
        4'b1001:
            _98 <= _93;
        4'b1010:
            _98 <= _97;
        default:
            _98 <= _91;
        endcase
    end
    assign _2 = _98;
    always @(posedge _37) begin
        if (_35)
            _91 <= _59;
        else
            _91 <= _2;
    end
    assign _100 = _91 & _60;
    assign _99 = 7'b0000000;
    assign _101 = { _99,
                    _100 };
    assign _103 = _102 == _45;
    assign _104 = _102 == _45;
    assign _705 = _423 == _45;
    assign _44 = 4'b0000;
    assign _7 = m_tready;
    assign _702 = _7 ? _346 : _45;
    assign _701 = _504 ? _107 : _88;
    assign _697 = _83 ? _102 : _107;
    assign _698 = _81 ? _421 : _697;
    assign _699 = _75 ? _421 : _698;
    assign _700 = _69 ? _421 : _699;
    assign _102 = 4'b1110;
    assign _695 = _58 ? _102 : _421;
    assign _696 = _51 ? _421 : _695;
    assign _88 = 4'b1010;
    assign _64 = 4'b1001;
    assign _691 = _119 < _78;
    assign _692 = ~ _691;
    assign _687 = 16'b0000000000000000;
    assign _683 = 16'b0000000000000001;
    assign _678 = 8'b00000000;
    assign _677 = _676[7:0];
    assign _679 = { _677,
                    _678 };
    assign _673 = _672[11:0];
    assign _675 = { _673,
                    _44 };
    assign _670 = 2'b00;
    assign _669 = _668[13:0];
    assign _671 = { _669,
                    _670 };
    assign _667 = 16'b0000000000000010;
    assign _665 = _660[0:0];
    assign _668 = _665 ? _667 : _683;
    assign _664 = _660[1:1];
    assign _672 = _664 ? _671 : _668;
    assign _663 = _660[2:2];
    assign _676 = _663 ? _675 : _672;
    assign _662 = _660[3:3];
    assign _680 = _662 ? _679 : _676;
    assign _660 = _72[4:0];
    assign _661 = _660[4:4];
    assign _682 = _661 ? _687 : _680;
    assign _684 = _682 - _683;
    assign _685 = ~ _684;
    assign _686 = _445 & _685;
    assign _688 = _686 == _687;
    assign _689 = ~ _688;
    assign _123 = _122 ? vdd : gnd;
    assign _121 = _120 ? vdd : gnd;
    always @* begin
        case (_45)
        4'b0011:
            _124 <= vdd;
        4'b1001:
            _124 <= _121;
        4'b1101:
            _124 <= _123;
        default:
            _124 <= gnd;
        endcase
    end
    assign _8 = _124;
    assign _448 = ~ _445;
    assign _449 = _166 & _448;
    assign _122 = _119 < _78;
    assign _450 = _122 ? _449 : _687;
    assign _442 = _441[7:0];
    assign _444 = { _442,
                    _678 };
    assign _438 = _437[11:0];
    assign _440 = { _438,
                    _44 };
    assign _434 = _433[13:0];
    assign _436 = { _434,
                    _670 };
    assign _430 = _429[14:0];
    assign _432 = { _430,
                    _59 };
    assign _423 = 4'b0010;
    assign _421 = 4'b0110;
    always @* begin
        case (_180)
        0:
            _425 <= _421;
        1:
            _425 <= _102;
        2:
            _425 <= _423;
        default:
            _425 <= _44;
        endcase
    end
    assign _417 = 4'b0111;
    assign _416 = 4'b0100;
    always @* begin
        case (_180)
        0:
            _420 <= _416;
        1:
            _420 <= _417;
        2:
            _420 <= _421;
        default:
            _420 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _415 <= _44;
        1:
            _415 <= _102;
        2:
            _415 <= _416;
        default:
            _415 <= _102;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _410 <= _102;
        1:
            _410 <= _416;
        2:
            _410 <= _102;
        default:
            _410 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _405 <= _421;
        1:
            _405 <= _102;
        2:
            _405 <= _423;
        default:
            _405 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _400 <= _44;
        1:
            _400 <= _102;
        2:
            _400 <= _416;
        default:
            _400 <= _102;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _395 <= _416;
        1:
            _395 <= _417;
        2:
            _395 <= _421;
        default:
            _395 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _390 <= _417;
        1:
            _390 <= _423;
        2:
            _390 <= _417;
        default:
            _390 <= _44;
        endcase
    end
    always @* begin
        case (_67)
        0:
            _426 <= _390;
        1:
            _426 <= _395;
        2:
            _426 <= _400;
        3:
            _426 <= _405;
        4:
            _426 <= _410;
        5:
            _426 <= _415;
        6:
            _426 <= _420;
        default:
            _426 <= _425;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _384 <= _416;
        1:
            _384 <= _102;
        2:
            _384 <= _421;
        default:
            _384 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _379 <= _421;
        1:
            _379 <= _417;
        2:
            _379 <= _423;
        default:
            _379 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _374 <= _44;
        1:
            _374 <= _102;
        2:
            _374 <= _416;
        default:
            _374 <= _102;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _369 <= _102;
        1:
            _369 <= _416;
        2:
            _369 <= _102;
        default:
            _369 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _364 <= _416;
        1:
            _364 <= _102;
        2:
            _364 <= _421;
        default:
            _364 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _359 <= _44;
        1:
            _359 <= _102;
        2:
            _359 <= _416;
        default:
            _359 <= _102;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _354 <= _421;
        1:
            _354 <= _417;
        2:
            _354 <= _423;
        default:
            _354 <= _44;
        endcase
    end
    assign _346 = 4'b0001;
    always @* begin
        case (_180)
        0:
            _349 <= _417;
        1:
            _349 <= _346;
        2:
            _349 <= _417;
        default:
            _349 <= _44;
        endcase
    end
    always @* begin
        case (_67)
        0:
            _385 <= _349;
        1:
            _385 <= _354;
        2:
            _385 <= _359;
        3:
            _385 <= _364;
        4:
            _385 <= _369;
        5:
            _385 <= _374;
        6:
            _385 <= _379;
        default:
            _385 <= _384;
        endcase
    end
    assign _340 = 4'b1100;
    always @* begin
        case (_180)
        0:
            _343 <= _421;
        1:
            _343 <= _340;
        2:
            _343 <= _421;
        default:
            _343 <= _44;
        endcase
    end
    assign _335 = 4'b0011;
    always @* begin
        case (_180)
        0:
            _338 <= _421;
        1:
            _338 <= _335;
        2:
            _338 <= _421;
        default:
            _338 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _333 <= _421;
        1:
            _333 <= _335;
        2:
            _333 <= _421;
        default:
            _333 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _328 <= _421;
        1:
            _328 <= _340;
        2:
            _328 <= _421;
        default:
            _328 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _323 <= _421;
        1:
            _323 <= _417;
        2:
            _323 <= _421;
        default:
            _323 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _318 <= _421;
        1:
            _318 <= _417;
        2:
            _318 <= _421;
        default:
            _318 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _313 <= _421;
        1:
            _313 <= _417;
        2:
            _313 <= _421;
        default:
            _313 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _308 <= _421;
        1:
            _308 <= _417;
        2:
            _308 <= _421;
        default:
            _308 <= _44;
        endcase
    end
    always @* begin
        case (_67)
        0:
            _344 <= _308;
        1:
            _344 <= _313;
        2:
            _344 <= _318;
        3:
            _344 <= _323;
        4:
            _344 <= _328;
        5:
            _344 <= _333;
        6:
            _344 <= _338;
        default:
            _344 <= _343;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _302 <= _340;
        1:
            _302 <= _421;
        2:
            _302 <= _421;
        default:
            _302 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _297 <= _421;
        1:
            _297 <= _417;
        2:
            _297 <= _335;
        default:
            _297 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _292 <= _44;
        1:
            _292 <= _421;
        2:
            _292 <= _102;
        default:
            _292 <= _335;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _287 <= _340;
        1:
            _287 <= _102;
        2:
            _287 <= _421;
        default:
            _287 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _282 <= _421;
        1:
            _282 <= _421;
        2:
            _282 <= _335;
        default:
            _282 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _277 <= _44;
        1:
            _277 <= _340;
        2:
            _277 <= _102;
        default:
            _277 <= _421;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _272 <= _340;
        1:
            _272 <= _421;
        2:
            _272 <= _421;
        default:
            _272 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _267 <= _421;
        1:
            _267 <= _417;
        2:
            _267 <= _335;
        default:
            _267 <= _44;
        endcase
    end
    always @* begin
        case (_67)
        0:
            _303 <= _267;
        1:
            _303 <= _272;
        2:
            _303 <= _277;
        3:
            _303 <= _282;
        4:
            _303 <= _287;
        5:
            _303 <= _292;
        6:
            _303 <= _297;
        default:
            _303 <= _302;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _261 <= _423;
        1:
            _261 <= _102;
        2:
            _261 <= _421;
        default:
            _261 <= _44;
        endcase
    end
    assign _255 = 4'b1000;
    always @* begin
        case (_180)
        0:
            _256 <= _44;
        1:
            _256 <= _340;
        2:
            _256 <= _421;
        default:
            _256 <= _255;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _251 <= _44;
        1:
            _251 <= _102;
        2:
            _251 <= _421;
        default:
            _251 <= _335;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _246 <= _340;
        1:
            _246 <= _102;
        2:
            _246 <= _421;
        default:
            _246 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _241 <= _255;
        1:
            _241 <= _102;
        2:
            _241 <= _421;
        default:
            _241 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _236 <= _44;
        1:
            _236 <= _102;
        2:
            _236 <= _421;
        default:
            _236 <= _340;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _231 <= _421;
        1:
            _231 <= _417;
        2:
            _231 <= _346;
        default:
            _231 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _226 <= _335;
        1:
            _226 <= _421;
        2:
            _226 <= _417;
        default:
            _226 <= _44;
        endcase
    end
    always @* begin
        case (_67)
        0:
            _262 <= _226;
        1:
            _262 <= _231;
        2:
            _262 <= _236;
        3:
            _262 <= _241;
        4:
            _262 <= _246;
        5:
            _262 <= _251;
        6:
            _262 <= _256;
        default:
            _262 <= _261;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _220 <= _255;
        1:
            _220 <= _102;
        2:
            _220 <= _421;
        default:
            _220 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _215 <= _44;
        1:
            _215 <= _417;
        2:
            _215 <= _421;
        default:
            _215 <= _416;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _210 <= _44;
        1:
            _210 <= _335;
        2:
            _210 <= _421;
        default:
            _210 <= _340;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _205 <= _421;
        1:
            _205 <= _340;
        2:
            _205 <= _421;
        default:
            _205 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _200 <= _340;
        1:
            _200 <= _102;
        2:
            _200 <= _421;
        default:
            _200 <= _44;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _195 <= _44;
        1:
            _195 <= _102;
        2:
            _195 <= _421;
        default:
            _195 <= _421;
        endcase
    end
    always @* begin
        case (_180)
        0:
            _190 <= _421;
        1:
            _190 <= _417;
        2:
            _190 <= _335;
        default:
            _190 <= _44;
        endcase
    end
    assign _180 = _117[1:0];
    always @* begin
        case (_180)
        0:
            _185 <= _421;
        1:
            _185 <= _421;
        2:
            _185 <= _417;
        default:
            _185 <= _44;
        endcase
    end
    always @* begin
        case (_67)
        0:
            _221 <= _185;
        1:
            _221 <= _190;
        2:
            _221 <= _195;
        3:
            _221 <= _200;
        4:
            _221 <= _205;
        5:
            _221 <= _210;
        6:
            _221 <= _215;
        default:
            _221 <= _220;
        endcase
    end
    assign _178 = 3'b000;
    assign _146 = _145 ? vdd : gnd;
    always @* begin
        case (_45)
        4'b0100:
            _148 <= _146;
        default:
            _148 <= gnd;
        endcase
    end
    assign _9 = _148;
    assign _150 = _145 ? _126 : _178;
    always @* begin
        case (_45)
        4'b0100:
            _151 <= _150;
        default:
            _151 <= _178;
        endcase
    end
    assign _10 = _151;
    always @(posedge _37) begin
        if (_9)
            _159[_11] <= _10;
    end
    assign _152 = _416 == _45;
    assign _153 = _152 ? _55 : _53;
    assign _156 = _114 ? _155 : _153;
    assign _157 = _145 ? _55 : _156;
    always @* begin
        case (_45)
        4'b0100:
            _158 <= _157;
        default:
            _158 <= _156;
        endcase
    end
    assign _11 = _158;
    assign _160 = _159[_11];
    always @(posedge _37) begin
        _161 <= _160;
    end
    assign _12 = _161;
    always @(posedge _37) begin
        if (_35)
            _179 <= _178;
        else
            _179 <= _12;
    end
    always @* begin
        case (_179)
        0:
            _427 <= _221;
        1:
            _427 <= _262;
        2:
            _427 <= _303;
        3:
            _427 <= _344;
        4:
            _427 <= _385;
        default:
            _427 <= _426;
        endcase
    end
    assign _177 = 12'b000000000000;
    assign _428 = { _177,
                    _427 };
    assign _174 = _119 < _78;
    assign _172 = 3'b100;
    assign _173 = _117 < _172;
    assign _175 = _173 & _174;
    assign _429 = _175 ? _428 : _687;
    assign _171 = _167[0:0];
    assign _433 = _171 ? _432 : _429;
    assign _170 = _167[1:1];
    assign _437 = _170 ? _436 : _433;
    assign _169 = _167[2:2];
    assign _441 = _169 ? _440 : _437;
    assign _167 = _70[3:0];
    assign _168 = _167[3:3];
    assign _445 = _168 ? _444 : _441;
    assign _446 = _166 | _445;
    assign _120 = _119 < _78;
    assign _447 = _120 ? _446 : _687;
    always @* begin
        case (_45)
        4'b0011:
            _451 <= _687;
        4'b1001:
            _451 <= _447;
        4'b1101:
            _451 <= _450;
        default:
            _451 <= _687;
        endcase
    end
    assign _13 = _451;
    always @(posedge _37) begin
        if (_8)
            _164[_24] <= _13;
    end
    assign _117 = _114 ? _116 : _49;
    assign _106 = 5'b00000;
    assign _118 = { _106,
                    _117 };
    assign _65 = 19'b0000000000000000000;
    assign _454 = _81 ? vdd : gnd;
    assign _455 = _75 ? vdd : _454;
    assign _456 = _69 ? vdd : _455;
    assign gnd = 1'b0;
    assign _452 = _58 ? gnd : vdd;
    assign _453 = _51 ? gnd : _452;
    assign vdd = 1'b1;
    always @* begin
        case (_45)
        4'b0101:
            _457 <= vdd;
        4'b1001:
            _457 <= _453;
        4'b1010:
            _457 <= _456;
        default:
            _457 <= gnd;
        endcase
    end
    assign _14 = _457;
    assign _478 = { _76,
                    _70 };
    assign _476 = 3'b001;
    assign _477 = _67 + _476;
    assign _479 = { _477,
                    _478 };
    assign _471 = 8'b00000001;
    assign _472 = _70 + _471;
    assign _473 = { _76,
                    _472 };
    assign _474 = { _178,
                    _473 };
    assign _465 = _76 + _471;
    assign _467 = { _465,
                    _678 };
    assign _468 = { _178,
                    _467 };
    assign _469 = _81 ? _468 : _65;
    assign _475 = _75 ? _474 : _469;
    assign _480 = _69 ? _479 : _475;
    assign _461 = _58 ? _65 : _65;
    assign _462 = _51 ? _65 : _461;
    always @* begin
        case (_45)
        4'b0101:
            _481 <= _65;
        4'b1001:
            _481 <= _462;
        4'b1010:
            _481 <= _480;
        default:
            _481 <= _65;
        endcase
    end
    assign _15 = _481;
    always @(posedge _37) begin
        if (_14)
            _538[_22] <= _15;
    end
    assign _112 = 4'b1101;
    assign _113 = _112 == _45;
    assign _110 = _340 == _45;
    assign _107 = 4'b1011;
    assign _108 = _107 == _45;
    assign _111 = _108 | _110;
    assign _114 = _111 | _113;
    assign _534 = _114 ? _155 : _53;
    assign _533 = _53 + _346;
    assign _535 = _58 ? _534 : _533;
    assign _50 = 3'b011;
    assign _529 = _504 ? _49 : _178;
    assign _523 = _81 ? _178 : _49;
    assign _525 = _75 ? _178 : _523;
    assign _527 = _69 ? _178 : _525;
    assign _520 = _49 + _476;
    assign _57 = _55 - _346;
    assign _483 = _53 - _346;
    assign _484 = _83 ? _155 : _483;
    assign _485 = _81 ? _155 : _484;
    assign _486 = _75 ? _155 : _485;
    assign _487 = _69 ? _155 : _486;
    always @* begin
        case (_45)
        4'b1010:
            _488 <= _487;
        default:
            _488 <= _155;
        endcase
    end
    assign _16 = _488;
    always @(posedge _37) begin
        if (_35)
            _155 <= _44;
        else
            _155 <= _16;
    end
    assign _506 = _116 + _476;
    assign _507 = _504 ? _506 : _116;
    assign _83 = _53 == _44;
    assign _499 = _83 ? _116 : _178;
    assign _491 = _490 ? _32 : _78;
    assign _492 = _41 ? _491 : _78;
    always @* begin
        case (_45)
        4'b0010:
            _494 <= _492;
        default:
            _494 <= _78;
        endcase
    end
    assign _17 = _494;
    always @(posedge _37) begin
        if (_35)
            _78 <= _678;
        else
            _78 <= _17;
    end
    assign _80 = _78 - _471;
    assign _81 = _76 < _80;
    assign _500 = _81 ? _116 : _499;
    assign _495 = _41 ? _32 : _72;
    always @* begin
        case (_45)
        4'b0001:
            _497 <= _495;
        default:
            _497 <= _72;
        endcase
    end
    assign _18 = _497;
    always @(posedge _37) begin
        if (_35)
            _72 <= _678;
        else
            _72 <= _18;
    end
    assign _74 = _72 - _471;
    assign _70 = _66[7:0];
    assign _75 = _70 < _74;
    assign _501 = _75 ? _116 : _500;
    assign _68 = 3'b111;
    assign _67 = _66[18:16];
    assign _69 = _67 < _68;
    assign _502 = _69 ? _116 : _501;
    always @* begin
        case (_45)
        4'b1010:
            _508 <= _502;
        4'b1101:
            _508 <= _507;
        default:
            _508 <= _116;
        endcase
    end
    assign _19 = _508;
    always @(posedge _37) begin
        if (_35)
            _116 <= _178;
        else
            _116 <= _19;
    end
    assign _504 = _116 < _50;
    assign _514 = _504 ? _53 : _155;
    assign _511 = _53 + _346;
    assign _512 = _58 ? _53 : _511;
    assign _513 = _51 ? _53 : _512;
    always @* begin
        case (_45)
        4'b0101:
            _515 <= _44;
        4'b1001:
            _515 <= _513;
        4'b1101:
            _515 <= _514;
        default:
            _515 <= _53;
        endcase
    end
    assign _20 = _515;
    always @(posedge _37) begin
        if (_35)
            _53 <= _44;
        else
            _53 <= _20;
    end
    assign _58 = _53 == _57;
    assign _518 = _58 ? _49 : _178;
    assign _521 = _51 ? _520 : _518;
    always @* begin
        case (_45)
        4'b0101:
            _530 <= _178;
        4'b1001:
            _530 <= _521;
        4'b1010:
            _530 <= _527;
        4'b1101:
            _530 <= _529;
        default:
            _530 <= _49;
        endcase
    end
    assign _21 = _530;
    always @(posedge _37) begin
        if (_35)
            _49 <= _178;
        else
            _49 <= _21;
    end
    assign _51 = _49 < _50;
    assign _536 = _51 ? _534 : _535;
    always @* begin
        case (_45)
        4'b0101:
            _537 <= _44;
        4'b1001:
            _537 <= _536;
        default:
            _537 <= _534;
        endcase
    end
    assign _22 = _537;
    assign _539 = _538[_22];
    always @(posedge _37) begin
        _540 <= _539;
    end
    assign _23 = _540;
    always @(posedge _37) begin
        if (_35)
            _66 <= _65;
        else
            _66 <= _23;
    end
    assign _76 = _66[15:8];
    assign _119 = _76 + _118;
    assign _543 = _119[3:0];
    always @* begin
        case (_45)
        4'b0011:
            _544 <= _542;
        default:
            _544 <= _543;
        endcase
    end
    assign _24 = _544;
    assign _165 = _164[_24];
    always @(posedge _37) begin
        _166 <= _165;
    end
    assign _656 = _166 & _445;
    assign _658 = _656 == _687;
    assign _659 = ~ _658;
    assign _690 = _659 | _689;
    assign _693 = _690 | _692;
    assign _694 = _693 ? _88 : _64;
    assign _47 = 4'b0101;
    assign _651 = _639 ? _47 : _45;
    assign _652 = _145 ? _45 : _651;
    assign _650 = _546 ? _416 : _45;
    assign _647 = _618 ? _335 : _45;
    assign _641 = _126 + _476;
    assign _638 = 3'b101;
    assign _639 = _126 == _638;
    assign _642 = _639 ? _126 : _641;
    assign _550 = _55 + _346;
    assign _551 = _145 ? _550 : _55;
    assign _548 = _546 ? _44 : _55;
    always @* begin
        case (_45)
        4'b0011:
            _552 <= _548;
        4'b0100:
            _552 <= _551;
        default:
            _552 <= _55;
        endcase
    end
    assign _25 = _552;
    always @(posedge _37) begin
        if (_35)
            _55 <= _44;
        else
            _55 <= _25;
    end
    assign _144 = _55 < _340;
    assign _560 = _138 - _471;
    always @* begin
        case (_126)
        3'b101:
            _562 <= _560;
        default:
            _562 <= _138;
        endcase
    end
    assign _563 = _145 ? _562 : _138;
    always @* begin
        case (_554)
        3'b101:
            _556 <= _32;
        default:
            _556 <= _138;
        endcase
    end
    assign _557 = _490 ? _138 : _556;
    assign _558 = _41 ? _557 : _138;
    always @* begin
        case (_45)
        4'b0010:
            _564 <= _558;
        4'b0100:
            _564 <= _563;
        default:
            _564 <= _138;
        endcase
    end
    assign _26 = _564;
    always @(posedge _37) begin
        if (_35)
            _138 <= _678;
        else
            _138 <= _26;
    end
    assign _570 = _136 - _471;
    always @* begin
        case (_126)
        3'b100:
            _572 <= _570;
        default:
            _572 <= _136;
        endcase
    end
    assign _573 = _145 ? _572 : _136;
    always @* begin
        case (_554)
        3'b100:
            _566 <= _32;
        default:
            _566 <= _136;
        endcase
    end
    assign _567 = _490 ? _136 : _566;
    assign _568 = _41 ? _567 : _136;
    always @* begin
        case (_45)
        4'b0010:
            _574 <= _568;
        4'b0100:
            _574 <= _573;
        default:
            _574 <= _136;
        endcase
    end
    assign _27 = _574;
    always @(posedge _37) begin
        if (_35)
            _136 <= _678;
        else
            _136 <= _27;
    end
    assign _580 = _134 - _471;
    always @* begin
        case (_126)
        3'b011:
            _582 <= _580;
        default:
            _582 <= _134;
        endcase
    end
    assign _583 = _145 ? _582 : _134;
    always @* begin
        case (_554)
        3'b011:
            _576 <= _32;
        default:
            _576 <= _134;
        endcase
    end
    assign _577 = _490 ? _134 : _576;
    assign _578 = _41 ? _577 : _134;
    always @* begin
        case (_45)
        4'b0010:
            _584 <= _578;
        4'b0100:
            _584 <= _583;
        default:
            _584 <= _134;
        endcase
    end
    assign _28 = _584;
    always @(posedge _37) begin
        if (_35)
            _134 <= _678;
        else
            _134 <= _28;
    end
    assign _590 = _132 - _471;
    always @* begin
        case (_126)
        3'b010:
            _592 <= _590;
        default:
            _592 <= _132;
        endcase
    end
    assign _593 = _145 ? _592 : _132;
    always @* begin
        case (_554)
        3'b010:
            _586 <= _32;
        default:
            _586 <= _132;
        endcase
    end
    assign _587 = _490 ? _132 : _586;
    assign _588 = _41 ? _587 : _132;
    always @* begin
        case (_45)
        4'b0010:
            _594 <= _588;
        4'b0100:
            _594 <= _593;
        default:
            _594 <= _132;
        endcase
    end
    assign _29 = _594;
    always @(posedge _37) begin
        if (_35)
            _132 <= _678;
        else
            _132 <= _29;
    end
    assign _600 = _130 - _471;
    always @* begin
        case (_126)
        3'b001:
            _602 <= _600;
        default:
            _602 <= _130;
        endcase
    end
    assign _603 = _145 ? _602 : _130;
    always @* begin
        case (_554)
        3'b001:
            _596 <= _32;
        default:
            _596 <= _130;
        endcase
    end
    assign _597 = _490 ? _130 : _596;
    assign _598 = _41 ? _597 : _130;
    always @* begin
        case (_45)
        4'b0010:
            _604 <= _598;
        4'b0100:
            _604 <= _603;
        default:
            _604 <= _130;
        endcase
    end
    assign _30 = _604;
    always @(posedge _37) begin
        if (_35)
            _130 <= _678;
        else
            _130 <= _30;
    end
    assign _610 = _128 - _471;
    always @* begin
        case (_126)
        3'b000:
            _612 <= _610;
        default:
            _612 <= _128;
        endcase
    end
    assign _613 = _145 ? _612 : _128;
    assign _32 = s_tdata;
    assign _553 = 3'b010;
    assign _554 = _126 - _553;
    always @* begin
        case (_554)
        3'b000:
            _606 <= _32;
        default:
            _606 <= _128;
        endcase
    end
    assign _607 = _490 ? _128 : _606;
    assign _608 = _41 ? _607 : _128;
    always @* begin
        case (_45)
        4'b0010:
            _614 <= _608;
        4'b0100:
            _614 <= _613;
        default:
            _614 <= _128;
        endcase
    end
    assign _33 = _614;
    always @(posedge _37) begin
        if (_35)
            _128 <= _678;
        else
            _128 <= _33;
    end
    always @* begin
        case (_126)
        0:
            _139 <= _128;
        1:
            _139 <= _130;
        2:
            _139 <= _132;
        3:
            _139 <= _134;
        4:
            _139 <= _136;
        default:
            _139 <= _138;
        endcase
    end
    assign _141 = _139 == _678;
    assign _142 = ~ _141;
    assign _145 = _142 & _144;
    assign _643 = _145 ? _126 : _642;
    assign _545 = 4'b1111;
    assign _35 = clear;
    assign _37 = clock;
    assign _624 = _542 + _346;
    assign _625 = _546 ? _542 : _624;
    assign _620 = _618 ? _44 : _542;
    assign _621 = _616 ? _542 : _620;
    assign _622 = _41 ? _621 : _542;
    always @* begin
        case (_45)
        4'b0010:
            _626 <= _622;
        4'b0011:
            _626 <= _625;
        default:
            _626 <= _542;
        endcase
    end
    assign _38 = _626;
    always @(posedge _37) begin
        if (_35)
            _542 <= _44;
        else
            _542 <= _38;
    end
    assign _546 = _542 == _545;
    assign _637 = _546 ? _178 : _126;
    assign _490 = _126 == _476;
    assign _632 = _490 ? _553 : _126;
    assign _630 = _126 + _476;
    assign _618 = _126 == _68;
    assign _633 = _618 ? _632 : _630;
    assign _634 = _616 ? _632 : _633;
    assign _635 = _41 ? _634 : _126;
    assign _628 = _41 ? _476 : _126;
    always @* begin
        case (_45)
        4'b0001:
            _644 <= _628;
        4'b0010:
            _644 <= _635;
        4'b0011:
            _644 <= _637;
        4'b0100:
            _644 <= _643;
        default:
            _644 <= _126;
        endcase
    end
    assign _39 = _644;
    always @(posedge _37) begin
        if (_35)
            _126 <= _178;
        else
            _126 <= _39;
    end
    assign _616 = _126 == _476;
    assign _648 = _616 ? _45 : _647;
    assign _649 = _41 ? _648 : _45;
    assign _41 = s_tvalid;
    assign _646 = _41 ? _423 : _45;
    always @* begin
        case (_45)
        4'b0000:
            _703 <= _346;
        4'b0001:
            _703 <= _646;
        4'b0010:
            _703 <= _649;
        4'b0011:
            _703 <= _650;
        4'b0100:
            _703 <= _652;
        4'b0101:
            _703 <= _421;
        4'b0110:
            _703 <= _417;
        4'b0111:
            _703 <= _255;
        4'b1000:
            _703 <= _694;
        4'b1001:
            _703 <= _696;
        4'b1010:
            _703 <= _700;
        4'b1011:
            _703 <= _340;
        4'b1100:
            _703 <= _112;
        4'b1101:
            _703 <= _701;
        4'b1110:
            _703 <= _702;
        default:
            _703 <= _45;
        endcase
    end
    assign _42 = _703;
    always @(posedge _37) begin
        if (_35)
            _45 <= _44;
        else
            _45 <= _42;
    end
    assign _704 = _346 == _45;
    assign _706 = _704 | _705;
    assign s_tready = _706;
    assign m_tvalid = _104;
    assign m_tlast = _103;
    assign m_tdata = _101;

endmodule
module Day_12_solver_top (
    m_tready,
    s_tdata,
    s_tvalid,
    clear,
    clock,
    s_tready,
    m_tvalid,
    m_tlast,
    m_tdata
);

    input m_tready;
    input [7:0] s_tdata;
    input s_tvalid;
    input clear;
    input clock;
    output s_tready;
    output m_tvalid;
    output m_tlast;
    output [7:0] m_tdata;

    wire [7:0] _16;
    wire _17;
    wire _18;
    wire _5;
    wire [7:0] _7;
    wire _9;
    wire _11;
    wire _13;
    wire [10:0] _15;
    wire _19;
    assign _16 = _15[10:3];
    assign _17 = _15[2:2];
    assign _18 = _15[1:1];
    assign _5 = m_tready;
    assign _7 = s_tdata;
    assign _9 = s_tvalid;
    assign _11 = clear;
    assign _13 = clock;
    Day_12_solver
        Day_12_solver
        ( .clock(_13),
          .clear(_11),
          .s_tvalid(_9),
          .s_tdata(_7),
          .m_tready(_5),
          .s_tready(_15[0:0]),
          .m_tvalid(_15[1:1]),
          .m_tlast(_15[2:2]),
          .m_tdata(_15[10:3]) );
    assign _19 = _15[0:0];
    assign s_tready = _19;
    assign m_tvalid = _18;
    assign m_tlast = _17;
    assign m_tdata = _16;

endmodule

// Tiny Tapeout wrapper module
module tt_um_range_finder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    
    // Map Tiny Tapeout pins to day_12_solver interface
    wire clock = clk;
    wire clear = ~rst_n;
    wire s_tvalid = uio_in[0];
    wire m_tready = uio_in[1];
    wire [7:0] s_tdata = ui_in[7:0];
    
    wire s_tready;
    wire m_tvalid;
    wire m_tlast;
    wire [7:0] m_tdata;
    
    // Instantiate the solver
    Day_12_solver_top solver (
        .clock(clock),
        .clear(clear),
        .s_tvalid(s_tvalid),
        .s_tdata(s_tdata),
        .m_tready(m_tready),
        .s_tready(s_tready),
        .m_tvalid(m_tvalid),
        .m_tlast(m_tlast),
        .m_tdata(m_tdata)
    );
    
    // Output mapping
    assign uo_out[7:0] = m_tdata[7:0];
    
    // Bidirectional mapping
    assign uio_out[0] = s_tready;
    assign uio_out[1] = m_tvalid;
    assign uio_out[2] = m_tlast;
    assign uio_out[7:3] = 5'b0;

endmodule
