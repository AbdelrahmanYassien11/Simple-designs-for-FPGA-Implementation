module WashingMachineWithLCD(
    input clk,              // إشارة الساعة
    input reset,            // إشارة إعادة التعيين
    input power,            // إشارة التشغيل
    input water_full,       // إشارة امتلاء الماء
    input detergent_full,   // إشارة امتلاء المنظف
    output reg rs,          // Register select لشاشة LCD
    output reg rw,          // Read/Write لشاشة LCD
    output reg en,          // Enable لشاشة LCD
    output reg [7:0] data_out // البيانات المرسلة إلى LCD
);
    reg [1:0] state;       // الحالة (00: idle, 01: washing, 10: spin-dry)
    reg [3:0] count;       // عداد الوقت
    parameter WASH_TIME = 8'd100; // زمن الغسيل
    parameter SPINDRY_TIME = 8'd50; // زمن العصر

    // حالات التحكم في LCD
    parameter IDLE = 4'b0000;
    parameter WRITE_DATA = 4'b0001;

    initial begin
        state = 2'b00;      // البداية في حالة الخمول
        rs = 0;
        rw = 0;
        en = 0;
        data_out = 8'b00000000; // مسح البيانات
        count = 4'b0000;   // إعادة تعيين العداد
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            rs <= 0;
            rw <= 0;
            en <= 0;
            data_out <= 8'b00000000; // مسح البيانات
            count <= 4'b0000;       // إعادة تعيين العداد
        end else if (power) begin
            count <= count + 1; // زيادة العداد

            case (state)
                2'b00: begin // حالة الخمول
                    if (water_full && detergent_full) begin
                        state <= 2'b01; // الانتقال إلى حالة الغسيل
                        data_out <= 8'b01001000; // عرض "H" على الشاشة
                        rs <= 1; // وضع الكتابة
                        rw <= 0; // كتابة
                        en <= 1; // تفعيل
                        count <= 4'b0000; // إعادة تعيين العداد
                    end
                end
                2'b01: begin // حالة الغسيل
                    if (count >= WASH_TIME) begin
                        state <= 2'b10; // الانتقال إلى حالة العصر
                        data_out <= 8'b01010010; // عرض "R" على الشاشة (على سبيل المثال)
                        count <= 4'b0000; // إعادة تعيين العداد
                    end
                end
                2'b10: begin // حالة العصر
                    if (count >= SPINDRY_TIME) begin
                        state <= 2'b00; // العودة إلى حالة الخمول
                        data_out <= 8'b00000000; // مسح البيانات
                        count <= 4'b0000; // إعادة تعيين العداد
                    end
                end
            endcase
        end
    end

    // تفعيل إشارة Enable
    always @(posedge clk) begin
        if (en) begin
            en <= 0; // إيقاف تفعيل الإشارة بعد فترة قصيرة
        end else if (rs || rw) begin
            en <= 1; // تفعيل الإشارة عند إرسال البيانات
        end
    end

endmodule