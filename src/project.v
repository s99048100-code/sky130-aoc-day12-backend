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

    wire _57;
    wire _83;
    wire _84;
    wire _85;
    wire _86;
    wire _60;
    wire _61;
    reg _88;
    wire _1;
    reg _58;
    wire _93;
    wire _94;
    wire _95;
    wire _96;
    wire _91;
    wire _92;
    reg _97;
    wire _2;
    reg _90;
    wire _99;
    wire [6:0] _98;
    wire [7:0] _100;
    wire _102;
    wire _103;
    wire _699;
    wire [3:0] _42;
    wire _7;
    wire [3:0] _696;
    wire [3:0] _695;
    wire [3:0] _691;
    wire [3:0] _692;
    wire [3:0] _693;
    wire [3:0] _694;
    wire [3:0] _101;
    wire [3:0] _689;
    wire [3:0] _690;
    wire [3:0] _87;
    wire [3:0] _62;
    wire _685;
    wire _686;
    wire [15:0] _681;
    wire [15:0] _677;
    wire [7:0] _672;
    wire [7:0] _671;
    wire [15:0] _673;
    wire [11:0] _667;
    wire [15:0] _669;
    wire [1:0] _664;
    wire [13:0] _663;
    wire [15:0] _665;
    wire [15:0] _661;
    wire _659;
    wire [15:0] _662;
    wire _658;
    wire [15:0] _666;
    wire _657;
    wire [15:0] _670;
    wire _656;
    wire [15:0] _674;
    wire [4:0] _654;
    wire _655;
    wire [15:0] _676;
    wire [15:0] _678;
    wire [15:0] _679;
    wire [15:0] _680;
    wire _682;
    wire _683;
    wire _122;
    wire _120;
    reg _123;
    wire _8;
    wire [15:0] _445;
    wire [15:0] _446;
    wire _121;
    wire [15:0] _447;
    wire [7:0] _439;
    wire [15:0] _441;
    wire [11:0] _435;
    wire [15:0] _437;
    wire [13:0] _431;
    wire [15:0] _433;
    wire [14:0] _427;
    wire [15:0] _429;
    wire [3:0] _420;
    wire [3:0] _418;
    reg [3:0] _422;
    wire [3:0] _414;
    wire [3:0] _413;
    reg [3:0] _417;
    reg [3:0] _412;
    reg [3:0] _407;
    reg [3:0] _402;
    reg [3:0] _397;
    reg [3:0] _392;
    reg [3:0] _387;
    reg [3:0] _423;
    reg [3:0] _381;
    reg [3:0] _376;
    reg [3:0] _371;
    reg [3:0] _366;
    reg [3:0] _361;
    reg [3:0] _356;
    reg [3:0] _351;
    wire [3:0] _343;
    reg [3:0] _346;
    reg [3:0] _382;
    wire [3:0] _337;
    reg [3:0] _340;
    wire [3:0] _332;
    reg [3:0] _335;
    reg [3:0] _330;
    reg [3:0] _325;
    reg [3:0] _320;
    reg [3:0] _315;
    reg [3:0] _310;
    reg [3:0] _305;
    reg [3:0] _341;
    reg [3:0] _299;
    reg [3:0] _294;
    reg [3:0] _289;
    reg [3:0] _284;
    reg [3:0] _279;
    reg [3:0] _274;
    reg [3:0] _269;
    reg [3:0] _264;
    reg [3:0] _300;
    reg [3:0] _258;
    wire [3:0] _252;
    reg [3:0] _253;
    reg [3:0] _248;
    reg [3:0] _243;
    reg [3:0] _238;
    reg [3:0] _233;
    reg [3:0] _228;
    reg [3:0] _223;
    reg [3:0] _259;
    reg [3:0] _217;
    reg [3:0] _212;
    reg [3:0] _207;
    reg [3:0] _202;
    reg [3:0] _197;
    reg [3:0] _192;
    reg [3:0] _187;
    wire [1:0] _177;
    reg [3:0] _182;
    reg [3:0] _218;
    wire _145;
    reg _147;
    wire _9;
    wire [2:0] _148;
    wire [2:0] _149;
    reg [2:0] _150;
    wire [2:0] _10;
    reg [2:0] _174[0:11];
    wire _151;
    wire [3:0] _152;
    wire [3:0] _155;
    wire [3:0] _156;
    reg [3:0] _157;
    wire [3:0] _11;
    wire [2:0] _175;
    reg [2:0] _176;
    reg [3:0] _424;
    wire [11:0] _173;
    wire [15:0] _425;
    wire _170;
    wire [2:0] _168;
    wire _169;
    wire _171;
    wire [15:0] _426;
    wire _167;
    wire [15:0] _430;
    wire _166;
    wire [15:0] _434;
    wire _165;
    wire [15:0] _438;
    wire [3:0] _163;
    wire _164;
    wire [15:0] _442;
    wire [15:0] _443;
    wire _119;
    wire [15:0] _444;
    reg [15:0] _448;
    wire [15:0] _12;
    reg [15:0] _160[0:15];
    wire [2:0] _116;
    wire [4:0] _105;
    wire [7:0] _117;
    wire _451;
    wire _452;
    wire _453;
    wire gnd;
    wire _449;
    wire _450;
    wire vdd;
    reg _454;
    wire _13;
    wire [15:0] _475;
    wire [2:0] _473;
    wire [2:0] _474;
    wire [18:0] _476;
    wire [7:0] _468;
    wire [7:0] _469;
    wire [15:0] _470;
    wire [18:0] _471;
    wire [7:0] _462;
    wire [15:0] _464;
    wire [18:0] _465;
    wire [18:0] _466;
    wire [18:0] _472;
    wire [18:0] _477;
    wire [18:0] _457;
    wire [18:0] _458;
    wire [18:0] _459;
    reg [18:0] _478;
    wire [18:0] _14;
    reg [18:0] _63[0:11];
    wire [3:0] _111;
    wire _112;
    wire _109;
    wire [3:0] _106;
    wire _107;
    wire _110;
    wire _113;
    wire [3:0] _531;
    wire [3:0] _530;
    wire [3:0] _532;
    wire [2:0] _48;
    wire [2:0] _526;
    wire [2:0] _520;
    wire [2:0] _522;
    wire [2:0] _524;
    wire [2:0] _517;
    wire [3:0] _55;
    wire [3:0] _480;
    wire [3:0] _481;
    wire [3:0] _482;
    wire [3:0] _483;
    wire [3:0] _484;
    reg [3:0] _485;
    wire [3:0] _15;
    reg [3:0] _154;
    wire [2:0] _503;
    wire [2:0] _504;
    wire _82;
    wire [2:0] _496;
    wire [7:0] _488;
    wire [7:0] _489;
    reg [7:0] _491;
    wire [7:0] _16;
    reg [7:0] _77;
    wire [7:0] _79;
    wire _80;
    wire [2:0] _497;
    wire [7:0] _492;
    reg [7:0] _494;
    wire [7:0] _17;
    reg [7:0] _71;
    wire [7:0] _73;
    wire [7:0] _69;
    wire _74;
    wire [2:0] _498;
    wire [2:0] _67;
    wire [2:0] _66;
    wire _68;
    wire [2:0] _499;
    reg [2:0] _505;
    wire [2:0] _18;
    reg [2:0] _115;
    wire _501;
    wire [3:0] _511;
    wire [3:0] _508;
    wire [3:0] _509;
    wire [3:0] _510;
    reg [3:0] _512;
    wire [3:0] _19;
    reg [3:0] _51;
    wire _56;
    wire [2:0] _515;
    wire [2:0] _518;
    reg [2:0] _527;
    wire [2:0] _20;
    reg [2:0] _47;
    wire _49;
    wire [3:0] _533;
    reg [3:0] _534;
    wire [3:0] _21;
    wire [18:0] _64;
    reg [18:0] _65;
    wire [7:0] _75;
    wire [7:0] _118;
    wire [3:0] _537;
    reg [3:0] _538;
    wire [3:0] _22;
    wire [15:0] _161;
    reg [15:0] _162;
    wire [15:0] _650;
    wire _652;
    wire _653;
    wire _684;
    wire _687;
    wire [3:0] _688;
    wire [3:0] _45;
    wire [3:0] _645;
    wire [3:0] _646;
    wire [3:0] _644;
    wire [3:0] _641;
    wire [2:0] _635;
    wire [2:0] _632;
    wire _633;
    wire [2:0] _636;
    wire [3:0] _544;
    wire [3:0] _545;
    wire [3:0] _542;
    reg [3:0] _546;
    wire [3:0] _23;
    reg [3:0] _53;
    wire _143;
    wire [7:0] _554;
    reg [7:0] _556;
    wire [7:0] _557;
    reg [7:0] _550;
    wire [7:0] _551;
    wire [7:0] _552;
    reg [7:0] _558;
    wire [7:0] _24;
    reg [7:0] _137;
    wire [7:0] _564;
    reg [7:0] _566;
    wire [7:0] _567;
    reg [7:0] _560;
    wire [7:0] _561;
    wire [7:0] _562;
    reg [7:0] _568;
    wire [7:0] _25;
    reg [7:0] _135;
    wire [7:0] _574;
    reg [7:0] _576;
    wire [7:0] _577;
    reg [7:0] _570;
    wire [7:0] _571;
    wire [7:0] _572;
    reg [7:0] _578;
    wire [7:0] _26;
    reg [7:0] _133;
    wire [7:0] _584;
    reg [7:0] _586;
    wire [7:0] _587;
    reg [7:0] _580;
    wire [7:0] _581;
    wire [7:0] _582;
    reg [7:0] _588;
    wire [7:0] _27;
    reg [7:0] _131;
    wire [7:0] _594;
    reg [7:0] _596;
    wire [7:0] _597;
    reg [7:0] _590;
    wire [7:0] _591;
    wire [7:0] _592;
    reg [7:0] _598;
    wire [7:0] _28;
    reg [7:0] _129;
    wire [7:0] _604;
    reg [7:0] _606;
    wire [7:0] _607;
    wire [7:0] _30;
    wire [2:0] _547;
    wire [2:0] _548;
    reg [7:0] _600;
    wire [7:0] _601;
    wire [7:0] _602;
    reg [7:0] _608;
    wire [7:0] _31;
    reg [7:0] _127;
    reg [7:0] _138;
    wire _140;
    wire _141;
    wire _144;
    wire [2:0] _637;
    wire [3:0] _539;
    wire _33;
    wire _35;
    wire [3:0] _618;
    wire [3:0] _619;
    wire [3:0] _614;
    wire [3:0] _615;
    wire [3:0] _616;
    reg [3:0] _620;
    wire [3:0] _36;
    reg [3:0] _536;
    wire _540;
    wire [2:0] _631;
    wire _487;
    wire [2:0] _626;
    wire [2:0] _624;
    wire _612;
    wire [2:0] _627;
    wire [2:0] _628;
    wire [2:0] _629;
    wire [2:0] _622;
    reg [2:0] _638;
    wire [2:0] _37;
    reg [2:0] _125;
    wire _610;
    wire [3:0] _642;
    wire [3:0] _643;
    wire _39;
    wire [3:0] _640;
    reg [3:0] _697;
    wire [3:0] _40;
    (* fsm_encoding="one_hot" *)
    reg [3:0] _43;
    wire _698;
    wire _700;
    assign _57 = 1'b0;
    assign _83 = _82 ? vdd : _58;
    assign _84 = _80 ? _58 : _83;
    assign _85 = _74 ? _58 : _84;
    assign _86 = _68 ? _58 : _85;
    assign _60 = _56 ? vdd : _58;
    assign _61 = _49 ? _58 : _60;
    always @* begin
        case (_43)
        4'b0101:
            _88 <= gnd;
        4'b1001:
            _88 <= _61;
        4'b1010:
            _88 <= _86;
        default:
            _88 <= _58;
        endcase
    end
    assign _1 = _88;
    always @(posedge _35) begin
        if (_33)
            _58 <= _57;
        else
            _58 <= _1;
    end
    assign _93 = _82 ? gnd : _90;
    assign _94 = _80 ? _90 : _93;
    assign _95 = _74 ? _90 : _94;
    assign _96 = _68 ? _90 : _95;
    assign _91 = _56 ? vdd : _90;
    assign _92 = _49 ? _90 : _91;
    always @* begin
        case (_43)
        4'b0101:
            _97 <= gnd;
        4'b1001:
            _97 <= _92;
        4'b1010:
            _97 <= _96;
        default:
            _97 <= _90;
        endcase
    end
    assign _2 = _97;
    always @(posedge _35) begin
        if (_33)
            _90 <= _57;
        else
            _90 <= _2;
    end
    assign _99 = _90 & _58;
    assign _98 = 7'b0000000;
    assign _100 = { _98,
                    _99 };
    assign _102 = _101 == _43;
    assign _103 = _101 == _43;
    assign _699 = _420 == _43;
    assign _42 = 4'b0000;
    assign _7 = m_tready;
    assign _696 = _7 ? _343 : _43;
    assign _695 = _501 ? _106 : _87;
    assign _691 = _82 ? _101 : _106;
    assign _692 = _80 ? _418 : _691;
    assign _693 = _74 ? _418 : _692;
    assign _694 = _68 ? _418 : _693;
    assign _101 = 4'b1110;
    assign _689 = _56 ? _101 : _418;
    assign _690 = _49 ? _418 : _689;
    assign _87 = 4'b1010;
    assign _62 = 4'b1001;
    assign _685 = _118 < _77;
    assign _686 = ~ _685;
    assign _681 = 16'b0000000000000000;
    assign _677 = 16'b0000000000000001;
    assign _672 = 8'b00000000;
    assign _671 = _670[7:0];
    assign _673 = { _671,
                    _672 };
    assign _667 = _666[11:0];
    assign _669 = { _667,
                    _42 };
    assign _664 = 2'b00;
    assign _663 = _662[13:0];
    assign _665 = { _663,
                    _664 };
    assign _661 = 16'b0000000000000010;
    assign _659 = _654[0:0];
    assign _662 = _659 ? _661 : _677;
    assign _658 = _654[1:1];
    assign _666 = _658 ? _665 : _662;
    assign _657 = _654[2:2];
    assign _670 = _657 ? _669 : _666;
    assign _656 = _654[3:3];
    assign _674 = _656 ? _673 : _670;
    assign _654 = _71[4:0];
    assign _655 = _654[4:4];
    assign _676 = _655 ? _681 : _674;
    assign _678 = _676 - _677;
    assign _679 = ~ _678;
    assign _680 = _442 & _679;
    assign _682 = _680 == _681;
    assign _683 = ~ _682;
    assign _122 = _121 ? vdd : gnd;
    assign _120 = _119 ? vdd : gnd;
    always @* begin
        case (_43)
        4'b0011:
            _123 <= vdd;
        4'b1001:
            _123 <= _120;
        4'b1101:
            _123 <= _122;
        default:
            _123 <= gnd;
        endcase
    end
    assign _8 = _123;
    assign _445 = ~ _442;
    assign _446 = _162 & _445;
    assign _121 = _118 < _77;
    assign _447 = _121 ? _446 : _681;
    assign _439 = _438[7:0];
    assign _441 = { _439,
                    _672 };
    assign _435 = _434[11:0];
    assign _437 = { _435,
                    _42 };
    assign _431 = _430[13:0];
    assign _433 = { _431,
                    _664 };
    assign _427 = _426[14:0];
    assign _429 = { _427,
                    _57 };
    assign _420 = 4'b0010;
    assign _418 = 4'b0110;
    always @* begin
        case (_177)
        0:
            _422 <= _418;
        1:
            _422 <= _101;
        2:
            _422 <= _420;
        default:
            _422 <= _42;
        endcase
    end
    assign _414 = 4'b0111;
    assign _413 = 4'b0100;
    always @* begin
        case (_177)
        0:
            _417 <= _413;
        1:
            _417 <= _414;
        2:
            _417 <= _418;
        default:
            _417 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _412 <= _42;
        1:
            _412 <= _101;
        2:
            _412 <= _413;
        default:
            _412 <= _101;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _407 <= _101;
        1:
            _407 <= _413;
        2:
            _407 <= _101;
        default:
            _407 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _402 <= _418;
        1:
            _402 <= _101;
        2:
            _402 <= _420;
        default:
            _402 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _397 <= _42;
        1:
            _397 <= _101;
        2:
            _397 <= _413;
        default:
            _397 <= _101;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _392 <= _413;
        1:
            _392 <= _414;
        2:
            _392 <= _418;
        default:
            _392 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _387 <= _414;
        1:
            _387 <= _420;
        2:
            _387 <= _414;
        default:
            _387 <= _42;
        endcase
    end
    always @* begin
        case (_66)
        0:
            _423 <= _387;
        1:
            _423 <= _392;
        2:
            _423 <= _397;
        3:
            _423 <= _402;
        4:
            _423 <= _407;
        5:
            _423 <= _412;
        6:
            _423 <= _417;
        default:
            _423 <= _422;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _381 <= _413;
        1:
            _381 <= _101;
        2:
            _381 <= _418;
        default:
            _381 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _376 <= _418;
        1:
            _376 <= _414;
        2:
            _376 <= _420;
        default:
            _376 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _371 <= _42;
        1:
            _371 <= _101;
        2:
            _371 <= _413;
        default:
            _371 <= _101;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _366 <= _101;
        1:
            _366 <= _413;
        2:
            _366 <= _101;
        default:
            _366 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _361 <= _413;
        1:
            _361 <= _101;
        2:
            _361 <= _418;
        default:
            _361 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _356 <= _42;
        1:
            _356 <= _101;
        2:
            _356 <= _413;
        default:
            _356 <= _101;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _351 <= _418;
        1:
            _351 <= _414;
        2:
            _351 <= _420;
        default:
            _351 <= _42;
        endcase
    end
    assign _343 = 4'b0001;
    always @* begin
        case (_177)
        0:
            _346 <= _414;
        1:
            _346 <= _343;
        2:
            _346 <= _414;
        default:
            _346 <= _42;
        endcase
    end
    always @* begin
        case (_66)
        0:
            _382 <= _346;
        1:
            _382 <= _351;
        2:
            _382 <= _356;
        3:
            _382 <= _361;
        4:
            _382 <= _366;
        5:
            _382 <= _371;
        6:
            _382 <= _376;
        default:
            _382 <= _381;
        endcase
    end
    assign _337 = 4'b1100;
    always @* begin
        case (_177)
        0:
            _340 <= _418;
        1:
            _340 <= _337;
        2:
            _340 <= _418;
        default:
            _340 <= _42;
        endcase
    end
    assign _332 = 4'b0011;
    always @* begin
        case (_177)
        0:
            _335 <= _418;
        1:
            _335 <= _332;
        2:
            _335 <= _418;
        default:
            _335 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _330 <= _418;
        1:
            _330 <= _332;
        2:
            _330 <= _418;
        default:
            _330 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _325 <= _418;
        1:
            _325 <= _337;
        2:
            _325 <= _418;
        default:
            _325 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _320 <= _418;
        1:
            _320 <= _414;
        2:
            _320 <= _418;
        default:
            _320 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _315 <= _418;
        1:
            _315 <= _414;
        2:
            _315 <= _418;
        default:
            _315 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _310 <= _418;
        1:
            _310 <= _414;
        2:
            _310 <= _418;
        default:
            _310 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _305 <= _418;
        1:
            _305 <= _414;
        2:
            _305 <= _418;
        default:
            _305 <= _42;
        endcase
    end
    always @* begin
        case (_66)
        0:
            _341 <= _305;
        1:
            _341 <= _310;
        2:
            _341 <= _315;
        3:
            _341 <= _320;
        4:
            _341 <= _325;
        5:
            _341 <= _330;
        6:
            _341 <= _335;
        default:
            _341 <= _340;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _299 <= _337;
        1:
            _299 <= _418;
        2:
            _299 <= _418;
        default:
            _299 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _294 <= _418;
        1:
            _294 <= _414;
        2:
            _294 <= _332;
        default:
            _294 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _289 <= _42;
        1:
            _289 <= _418;
        2:
            _289 <= _101;
        default:
            _289 <= _332;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _284 <= _337;
        1:
            _284 <= _101;
        2:
            _284 <= _418;
        default:
            _284 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _279 <= _418;
        1:
            _279 <= _418;
        2:
            _279 <= _332;
        default:
            _279 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _274 <= _42;
        1:
            _274 <= _337;
        2:
            _274 <= _101;
        default:
            _274 <= _418;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _269 <= _337;
        1:
            _269 <= _418;
        2:
            _269 <= _418;
        default:
            _269 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _264 <= _418;
        1:
            _264 <= _414;
        2:
            _264 <= _332;
        default:
            _264 <= _42;
        endcase
    end
    always @* begin
        case (_66)
        0:
            _300 <= _264;
        1:
            _300 <= _269;
        2:
            _300 <= _274;
        3:
            _300 <= _279;
        4:
            _300 <= _284;
        5:
            _300 <= _289;
        6:
            _300 <= _294;
        default:
            _300 <= _299;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _258 <= _420;
        1:
            _258 <= _101;
        2:
            _258 <= _418;
        default:
            _258 <= _42;
        endcase
    end
    assign _252 = 4'b1000;
    always @* begin
        case (_177)
        0:
            _253 <= _42;
        1:
            _253 <= _337;
        2:
            _253 <= _418;
        default:
            _253 <= _252;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _248 <= _42;
        1:
            _248 <= _101;
        2:
            _248 <= _418;
        default:
            _248 <= _332;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _243 <= _337;
        1:
            _243 <= _101;
        2:
            _243 <= _418;
        default:
            _243 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _238 <= _252;
        1:
            _238 <= _101;
        2:
            _238 <= _418;
        default:
            _238 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _233 <= _42;
        1:
            _233 <= _101;
        2:
            _233 <= _418;
        default:
            _233 <= _337;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _228 <= _418;
        1:
            _228 <= _414;
        2:
            _228 <= _343;
        default:
            _228 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _223 <= _332;
        1:
            _223 <= _418;
        2:
            _223 <= _414;
        default:
            _223 <= _42;
        endcase
    end
    always @* begin
        case (_66)
        0:
            _259 <= _223;
        1:
            _259 <= _228;
        2:
            _259 <= _233;
        3:
            _259 <= _238;
        4:
            _259 <= _243;
        5:
            _259 <= _248;
        6:
            _259 <= _253;
        default:
            _259 <= _258;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _217 <= _252;
        1:
            _217 <= _101;
        2:
            _217 <= _418;
        default:
            _217 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _212 <= _42;
        1:
            _212 <= _414;
        2:
            _212 <= _418;
        default:
            _212 <= _413;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _207 <= _42;
        1:
            _207 <= _332;
        2:
            _207 <= _418;
        default:
            _207 <= _337;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _202 <= _418;
        1:
            _202 <= _337;
        2:
            _202 <= _418;
        default:
            _202 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _197 <= _337;
        1:
            _197 <= _101;
        2:
            _197 <= _418;
        default:
            _197 <= _42;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _192 <= _42;
        1:
            _192 <= _101;
        2:
            _192 <= _418;
        default:
            _192 <= _418;
        endcase
    end
    always @* begin
        case (_177)
        0:
            _187 <= _418;
        1:
            _187 <= _414;
        2:
            _187 <= _332;
        default:
            _187 <= _42;
        endcase
    end
    assign _177 = _116[1:0];
    always @* begin
        case (_177)
        0:
            _182 <= _418;
        1:
            _182 <= _418;
        2:
            _182 <= _414;
        default:
            _182 <= _42;
        endcase
    end
    always @* begin
        case (_66)
        0:
            _218 <= _182;
        1:
            _218 <= _187;
        2:
            _218 <= _192;
        3:
            _218 <= _197;
        4:
            _218 <= _202;
        5:
            _218 <= _207;
        6:
            _218 <= _212;
        default:
            _218 <= _217;
        endcase
    end
    assign _145 = _144 ? vdd : gnd;
    always @* begin
        case (_43)
        4'b0100:
            _147 <= _145;
        default:
            _147 <= gnd;
        endcase
    end
    assign _9 = _147;
    assign _148 = 3'b000;
    assign _149 = _144 ? _125 : _148;
    always @* begin
        case (_43)
        4'b0100:
            _150 <= _149;
        default:
            _150 <= _148;
        endcase
    end
    assign _10 = _150;
    always @(posedge _35) begin
        if (_9)
            _174[_11] <= _10;
    end
    assign _151 = _413 == _43;
    assign _152 = _151 ? _53 : _51;
    assign _155 = _113 ? _154 : _152;
    assign _156 = _144 ? _53 : _155;
    always @* begin
        case (_43)
        4'b0100:
            _157 <= _156;
        default:
            _157 <= _155;
        endcase
    end
    assign _11 = _157;
    assign _175 = _174[_11];
    always @(posedge _35) begin
        _176 <= _175;
    end
    always @* begin
        case (_176)
        0:
            _424 <= _218;
        1:
            _424 <= _259;
        2:
            _424 <= _300;
        3:
            _424 <= _341;
        4:
            _424 <= _382;
        default:
            _424 <= _423;
        endcase
    end
    assign _173 = 12'b000000000000;
    assign _425 = { _173,
                    _424 };
    assign _170 = _118 < _77;
    assign _168 = 3'b100;
    assign _169 = _116 < _168;
    assign _171 = _169 & _170;
    assign _426 = _171 ? _425 : _681;
    assign _167 = _163[0:0];
    assign _430 = _167 ? _429 : _426;
    assign _166 = _163[1:1];
    assign _434 = _166 ? _433 : _430;
    assign _165 = _163[2:2];
    assign _438 = _165 ? _437 : _434;
    assign _163 = _69[3:0];
    assign _164 = _163[3:3];
    assign _442 = _164 ? _441 : _438;
    assign _443 = _162 | _442;
    assign _119 = _118 < _77;
    assign _444 = _119 ? _443 : _681;
    always @* begin
        case (_43)
        4'b0011:
            _448 <= _681;
        4'b1001:
            _448 <= _444;
        4'b1101:
            _448 <= _447;
        default:
            _448 <= _681;
        endcase
    end
    assign _12 = _448;
    always @(posedge _35) begin
        if (_8)
            _160[_22] <= _12;
    end
    assign _116 = _113 ? _115 : _47;
    assign _105 = 5'b00000;
    assign _117 = { _105,
                    _116 };
    assign _451 = _80 ? vdd : gnd;
    assign _452 = _74 ? vdd : _451;
    assign _453 = _68 ? vdd : _452;
    assign gnd = 1'b0;
    assign _449 = _56 ? gnd : vdd;
    assign _450 = _49 ? gnd : _449;
    assign vdd = 1'b1;
    always @* begin
        case (_43)
        4'b0101:
            _454 <= vdd;
        4'b1001:
            _454 <= _450;
        4'b1010:
            _454 <= _453;
        default:
            _454 <= gnd;
        endcase
    end
    assign _13 = _454;
    assign _475 = { _75,
                    _69 };
    assign _473 = 3'b001;
    assign _474 = _66 + _473;
    assign _476 = { _474,
                    _475 };
    assign _468 = 8'b00000001;
    assign _469 = _69 + _468;
    assign _470 = { _75,
                    _469 };
    assign _471 = { _148,
                    _470 };
    assign _462 = _75 + _468;
    assign _464 = { _462,
                    _672 };
    assign _465 = { _148,
                    _464 };
    assign _466 = _80 ? _465 : _457;
    assign _472 = _74 ? _471 : _466;
    assign _477 = _68 ? _476 : _472;
    assign _457 = 19'b0000000000000000000;
    assign _458 = _56 ? _457 : _457;
    assign _459 = _49 ? _457 : _458;
    always @* begin
        case (_43)
        4'b0101:
            _478 <= _457;
        4'b1001:
            _478 <= _459;
        4'b1010:
            _478 <= _477;
        default:
            _478 <= _457;
        endcase
    end
    assign _14 = _478;
    always @(posedge _35) begin
        if (_13)
            _63[_21] <= _14;
    end
    assign _111 = 4'b1101;
    assign _112 = _111 == _43;
    assign _109 = _337 == _43;
    assign _106 = 4'b1011;
    assign _107 = _106 == _43;
    assign _110 = _107 | _109;
    assign _113 = _110 | _112;
    assign _531 = _113 ? _154 : _51;
    assign _530 = _51 + _343;
    assign _532 = _56 ? _531 : _530;
    assign _48 = 3'b011;
    assign _526 = _501 ? _47 : _148;
    assign _520 = _80 ? _148 : _47;
    assign _522 = _74 ? _148 : _520;
    assign _524 = _68 ? _148 : _522;
    assign _517 = _47 + _473;
    assign _55 = _53 - _343;
    assign _480 = _51 - _343;
    assign _481 = _82 ? _154 : _480;
    assign _482 = _80 ? _154 : _481;
    assign _483 = _74 ? _154 : _482;
    assign _484 = _68 ? _154 : _483;
    always @* begin
        case (_43)
        4'b1010:
            _485 <= _484;
        default:
            _485 <= _154;
        endcase
    end
    assign _15 = _485;
    always @(posedge _35) begin
        if (_33)
            _154 <= _42;
        else
            _154 <= _15;
    end
    assign _503 = _115 + _473;
    assign _504 = _501 ? _503 : _115;
    assign _82 = _51 == _42;
    assign _496 = _82 ? _115 : _148;
    assign _488 = _487 ? _30 : _77;
    assign _489 = _39 ? _488 : _77;
    always @* begin
        case (_43)
        4'b0010:
            _491 <= _489;
        default:
            _491 <= _77;
        endcase
    end
    assign _16 = _491;
    always @(posedge _35) begin
        if (_33)
            _77 <= _672;
        else
            _77 <= _16;
    end
    assign _79 = _77 - _468;
    assign _80 = _75 < _79;
    assign _497 = _80 ? _115 : _496;
    assign _492 = _39 ? _30 : _71;
    always @* begin
        case (_43)
        4'b0001:
            _494 <= _492;
        default:
            _494 <= _71;
        endcase
    end
    assign _17 = _494;
    always @(posedge _35) begin
        if (_33)
            _71 <= _672;
        else
            _71 <= _17;
    end
    assign _73 = _71 - _468;
    assign _69 = _65[7:0];
    assign _74 = _69 < _73;
    assign _498 = _74 ? _115 : _497;
    assign _67 = 3'b111;
    assign _66 = _65[18:16];
    assign _68 = _66 < _67;
    assign _499 = _68 ? _115 : _498;
    always @* begin
        case (_43)
        4'b1010:
            _505 <= _499;
        4'b1101:
            _505 <= _504;
        default:
            _505 <= _115;
        endcase
    end
    assign _18 = _505;
    always @(posedge _35) begin
        if (_33)
            _115 <= _148;
        else
            _115 <= _18;
    end
    assign _501 = _115 < _48;
    assign _511 = _501 ? _51 : _154;
    assign _508 = _51 + _343;
    assign _509 = _56 ? _51 : _508;
    assign _510 = _49 ? _51 : _509;
    always @* begin
        case (_43)
        4'b0101:
            _512 <= _42;
        4'b1001:
            _512 <= _510;
        4'b1101:
            _512 <= _511;
        default:
            _512 <= _51;
        endcase
    end
    assign _19 = _512;
    always @(posedge _35) begin
        if (_33)
            _51 <= _42;
        else
            _51 <= _19;
    end
    assign _56 = _51 == _55;
    assign _515 = _56 ? _47 : _148;
    assign _518 = _49 ? _517 : _515;
    always @* begin
        case (_43)
        4'b0101:
            _527 <= _148;
        4'b1001:
            _527 <= _518;
        4'b1010:
            _527 <= _524;
        4'b1101:
            _527 <= _526;
        default:
            _527 <= _47;
        endcase
    end
    assign _20 = _527;
    always @(posedge _35) begin
        if (_33)
            _47 <= _148;
        else
            _47 <= _20;
    end
    assign _49 = _47 < _48;
    assign _533 = _49 ? _531 : _532;
    always @* begin
        case (_43)
        4'b0101:
            _534 <= _42;
        4'b1001:
            _534 <= _533;
        default:
            _534 <= _531;
        endcase
    end
    assign _21 = _534;
    assign _64 = _63[_21];
    always @(posedge _35) begin
        _65 <= _64;
    end
    assign _75 = _65[15:8];
    assign _118 = _75 + _117;
    assign _537 = _118[3:0];
    always @* begin
        case (_43)
        4'b0011:
            _538 <= _536;
        default:
            _538 <= _537;
        endcase
    end
    assign _22 = _538;
    assign _161 = _160[_22];
    always @(posedge _35) begin
        _162 <= _161;
    end
    assign _650 = _162 & _442;
    assign _652 = _650 == _681;
    assign _653 = ~ _652;
    assign _684 = _653 | _683;
    assign _687 = _684 | _686;
    assign _688 = _687 ? _87 : _62;
    assign _45 = 4'b0101;
    assign _645 = _633 ? _45 : _43;
    assign _646 = _144 ? _43 : _645;
    assign _644 = _540 ? _413 : _43;
    assign _641 = _612 ? _332 : _43;
    assign _635 = _125 + _473;
    assign _632 = 3'b101;
    assign _633 = _125 == _632;
    assign _636 = _633 ? _125 : _635;
    assign _544 = _53 + _343;
    assign _545 = _144 ? _544 : _53;
    assign _542 = _540 ? _42 : _53;
    always @* begin
        case (_43)
        4'b0011:
            _546 <= _542;
        4'b0100:
            _546 <= _545;
        default:
            _546 <= _53;
        endcase
    end
    assign _23 = _546;
    always @(posedge _35) begin
        if (_33)
            _53 <= _42;
        else
            _53 <= _23;
    end
    assign _143 = _53 < _337;
    assign _554 = _137 - _468;
    always @* begin
        case (_125)
        3'b101:
            _556 <= _554;
        default:
            _556 <= _137;
        endcase
    end
    assign _557 = _144 ? _556 : _137;
    always @* begin
        case (_548)
        3'b101:
            _550 <= _30;
        default:
            _550 <= _137;
        endcase
    end
    assign _551 = _487 ? _137 : _550;
    assign _552 = _39 ? _551 : _137;
    always @* begin
        case (_43)
        4'b0010:
            _558 <= _552;
        4'b0100:
            _558 <= _557;
        default:
            _558 <= _137;
        endcase
    end
    assign _24 = _558;
    always @(posedge _35) begin
        if (_33)
            _137 <= _672;
        else
            _137 <= _24;
    end
    assign _564 = _135 - _468;
    always @* begin
        case (_125)
        3'b100:
            _566 <= _564;
        default:
            _566 <= _135;
        endcase
    end
    assign _567 = _144 ? _566 : _135;
    always @* begin
        case (_548)
        3'b100:
            _560 <= _30;
        default:
            _560 <= _135;
        endcase
    end
    assign _561 = _487 ? _135 : _560;
    assign _562 = _39 ? _561 : _135;
    always @* begin
        case (_43)
        4'b0010:
            _568 <= _562;
        4'b0100:
            _568 <= _567;
        default:
            _568 <= _135;
        endcase
    end
    assign _25 = _568;
    always @(posedge _35) begin
        if (_33)
            _135 <= _672;
        else
            _135 <= _25;
    end
    assign _574 = _133 - _468;
    always @* begin
        case (_125)
        3'b011:
            _576 <= _574;
        default:
            _576 <= _133;
        endcase
    end
    assign _577 = _144 ? _576 : _133;
    always @* begin
        case (_548)
        3'b011:
            _570 <= _30;
        default:
            _570 <= _133;
        endcase
    end
    assign _571 = _487 ? _133 : _570;
    assign _572 = _39 ? _571 : _133;
    always @* begin
        case (_43)
        4'b0010:
            _578 <= _572;
        4'b0100:
            _578 <= _577;
        default:
            _578 <= _133;
        endcase
    end
    assign _26 = _578;
    always @(posedge _35) begin
        if (_33)
            _133 <= _672;
        else
            _133 <= _26;
    end
    assign _584 = _131 - _468;
    always @* begin
        case (_125)
        3'b010:
            _586 <= _584;
        default:
            _586 <= _131;
        endcase
    end
    assign _587 = _144 ? _586 : _131;
    always @* begin
        case (_548)
        3'b010:
            _580 <= _30;
        default:
            _580 <= _131;
        endcase
    end
    assign _581 = _487 ? _131 : _580;
    assign _582 = _39 ? _581 : _131;
    always @* begin
        case (_43)
        4'b0010:
            _588 <= _582;
        4'b0100:
            _588 <= _587;
        default:
            _588 <= _131;
        endcase
    end
    assign _27 = _588;
    always @(posedge _35) begin
        if (_33)
            _131 <= _672;
        else
            _131 <= _27;
    end
    assign _594 = _129 - _468;
    always @* begin
        case (_125)
        3'b001:
            _596 <= _594;
        default:
            _596 <= _129;
        endcase
    end
    assign _597 = _144 ? _596 : _129;
    always @* begin
        case (_548)
        3'b001:
            _590 <= _30;
        default:
            _590 <= _129;
        endcase
    end
    assign _591 = _487 ? _129 : _590;
    assign _592 = _39 ? _591 : _129;
    always @* begin
        case (_43)
        4'b0010:
            _598 <= _592;
        4'b0100:
            _598 <= _597;
        default:
            _598 <= _129;
        endcase
    end
    assign _28 = _598;
    always @(posedge _35) begin
        if (_33)
            _129 <= _672;
        else
            _129 <= _28;
    end
    assign _604 = _127 - _468;
    always @* begin
        case (_125)
        3'b000:
            _606 <= _604;
        default:
            _606 <= _127;
        endcase
    end
    assign _607 = _144 ? _606 : _127;
    assign _30 = s_tdata;
    assign _547 = 3'b010;
    assign _548 = _125 - _547;
    always @* begin
        case (_548)
        3'b000:
            _600 <= _30;
        default:
            _600 <= _127;
        endcase
    end
    assign _601 = _487 ? _127 : _600;
    assign _602 = _39 ? _601 : _127;
    always @* begin
        case (_43)
        4'b0010:
            _608 <= _602;
        4'b0100:
            _608 <= _607;
        default:
            _608 <= _127;
        endcase
    end
    assign _31 = _608;
    always @(posedge _35) begin
        if (_33)
            _127 <= _672;
        else
            _127 <= _31;
    end
    always @* begin
        case (_125)
        0:
            _138 <= _127;
        1:
            _138 <= _129;
        2:
            _138 <= _131;
        3:
            _138 <= _133;
        4:
            _138 <= _135;
        default:
            _138 <= _137;
        endcase
    end
    assign _140 = _138 == _672;
    assign _141 = ~ _140;
    assign _144 = _141 & _143;
    assign _637 = _144 ? _125 : _636;
    assign _539 = 4'b1111;
    assign _33 = clear;
    assign _35 = clock;
    assign _618 = _536 + _343;
    assign _619 = _540 ? _536 : _618;
    assign _614 = _612 ? _42 : _536;
    assign _615 = _610 ? _536 : _614;
    assign _616 = _39 ? _615 : _536;
    always @* begin
        case (_43)
        4'b0010:
            _620 <= _616;
        4'b0011:
            _620 <= _619;
        default:
            _620 <= _536;
        endcase
    end
    assign _36 = _620;
    always @(posedge _35) begin
        if (_33)
            _536 <= _42;
        else
            _536 <= _36;
    end
    assign _540 = _536 == _539;
    assign _631 = _540 ? _148 : _125;
    assign _487 = _125 == _473;
    assign _626 = _487 ? _547 : _125;
    assign _624 = _125 + _473;
    assign _612 = _125 == _67;
    assign _627 = _612 ? _626 : _624;
    assign _628 = _610 ? _626 : _627;
    assign _629 = _39 ? _628 : _125;
    assign _622 = _39 ? _473 : _125;
    always @* begin
        case (_43)
        4'b0001:
            _638 <= _622;
        4'b0010:
            _638 <= _629;
        4'b0011:
            _638 <= _631;
        4'b0100:
            _638 <= _637;
        default:
            _638 <= _125;
        endcase
    end
    assign _37 = _638;
    always @(posedge _35) begin
        if (_33)
            _125 <= _148;
        else
            _125 <= _37;
    end
    assign _610 = _125 == _473;
    assign _642 = _610 ? _43 : _641;
    assign _643 = _39 ? _642 : _43;
    assign _39 = s_tvalid;
    assign _640 = _39 ? _420 : _43;
    always @* begin
        case (_43)
        4'b0000:
            _697 <= _343;
        4'b0001:
            _697 <= _640;
        4'b0010:
            _697 <= _643;
        4'b0011:
            _697 <= _644;
        4'b0100:
            _697 <= _646;
        4'b0101:
            _697 <= _418;
        4'b0110:
            _697 <= _414;
        4'b0111:
            _697 <= _252;
        4'b1000:
            _697 <= _688;
        4'b1001:
            _697 <= _690;
        4'b1010:
            _697 <= _694;
        4'b1011:
            _697 <= _337;
        4'b1100:
            _697 <= _111;
        4'b1101:
            _697 <= _695;
        4'b1110:
            _697 <= _696;
        default:
            _697 <= _43;
        endcase
    end
    assign _40 = _697;
    always @(posedge _35) begin
        if (_33)
            _43 <= _42;
        else
            _43 <= _40;
    end
    assign _698 = _343 == _43;
    assign _700 = _698 | _699;
    assign s_tready = _700;
    assign m_tvalid = _103;
    assign m_tlast = _102;
    assign m_tdata = _100;

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
    Day_12_solver solver (
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
