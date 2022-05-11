if %5=="true" (
exit 0
)
REM Blank signature location
hexmate r0-8FFF,"%~2\%~3\%~4" r9080-FFFFFFFF,"%~2\%~3\%~4" -O"%~2\%~3\temp_original_copy.X.production.hex" -FILL=w1:0x00,0x00,0x00,0x00@0x9000:0x907F

REM Fill in unimplemented flash locations
hexmate r0-FFFFFFFF,"%~2\%~3\temp_original_copy.X.production.hex" -O"%~2\%~3\temp_original_copy.X.production.hex" -FILL=w1:0xFF,0xFF,0xFF,0x00@0x8000:0x2AFFF

REM Generate application binary image
hexmate r8000-2AFFFs-8000,"%~2\%~3\temp_original_copy.X.production.hex" -O"%~2\%~3\temp_original_copy.X.production.hex"
%1\xc16-objcopy -I ihex -O binary "%~2\%~3\temp_original_copy.X.production.hex" "%~2\%~3\iot_app.X.production.bin"

REM Sign binary file
java -jar signing_tool.jar -sign "%~2\%~3\iot_app.X.production.bin" ..\..\..\iot_boot.X\private_key.pem "%~2\%~3\iot_app.X.production.bin.signature.der"

REM Export signature value
java -jar signing_tool.jar -export "%~2\%~3\iot_app.X.production.bin.signature.der" "%~2\%~3\iot_app.X.production.bin.signature.bin"

REM Covert signature to .hex format
%1\xc16-objcopy -I binary -O ihex "%~2\%~3\iot_app.X.production.bin.signature.bin" "%~2\%~3\iot_app.X.production.bin.signature.hex"

REM Copy signature .hex into application .hex file application header
hexmate r0-1s9000,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9002-FFFFFFFF,"%~2\%~3\%~4" r0-8FFF,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r2-3s9002,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9006-FFFFFFFF,"%~2\%~3\%~4" r0-9003,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r4-5s9004,"%~2\%~3\iot_app.X.production.bin.signature.hex" r900A-FFFFFFFF,"%~2\%~3\%~4" r0-9007,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r6-7s9006,"%~2\%~3\iot_app.X.production.bin.signature.hex" r900E-FFFFFFFF,"%~2\%~3\%~4" r0-900B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r8-9s9008,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9012-FFFFFFFF,"%~2\%~3\%~4" r0-900F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate rA-Bs900A,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9016-FFFFFFFF,"%~2\%~3\%~4" r0-9013,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate rC-Ds900C,"%~2\%~3\iot_app.X.production.bin.signature.hex" r901A-FFFFFFFF,"%~2\%~3\%~4" r0-9017,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate rE-Fs900E,"%~2\%~3\iot_app.X.production.bin.signature.hex" r901E-FFFFFFFF,"%~2\%~3\%~4" r0-901B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r10-11s9010,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9022-FFFFFFFF,"%~2\%~3\%~4" r0-901F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r12-13s9012,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9026-FFFFFFFF,"%~2\%~3\%~4" r0-9023,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r14-15s9014,"%~2\%~3\iot_app.X.production.bin.signature.hex" r902A-FFFFFFFF,"%~2\%~3\%~4" r0-9027,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r16-17s9016,"%~2\%~3\iot_app.X.production.bin.signature.hex" r902E-FFFFFFFF,"%~2\%~3\%~4" r0-902B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r18-19s9018,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9032-FFFFFFFF,"%~2\%~3\%~4" r0-902F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r1A-1Bs901A,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9036-FFFFFFFF,"%~2\%~3\%~4" r0-9033,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r1C-1Ds901C,"%~2\%~3\iot_app.X.production.bin.signature.hex" r903A-FFFFFFFF,"%~2\%~3\%~4" r0-9037,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r1E-1Fs901E,"%~2\%~3\iot_app.X.production.bin.signature.hex" r903E-FFFFFFFF,"%~2\%~3\%~4" r0-903B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r20-21s9020,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9042-FFFFFFFF,"%~2\%~3\%~4" r0-903F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r22-23s9022,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9046-FFFFFFFF,"%~2\%~3\%~4" r0-9043,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r24-25s9024,"%~2\%~3\iot_app.X.production.bin.signature.hex" r904A-FFFFFFFF,"%~2\%~3\%~4" r0-9047,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r26-27s9026,"%~2\%~3\iot_app.X.production.bin.signature.hex" r904E-FFFFFFFF,"%~2\%~3\%~4" r0-904B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r28-29s9028,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9052-FFFFFFFF,"%~2\%~3\%~4" r0-904F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r2A-2Bs902A,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9056-FFFFFFFF,"%~2\%~3\%~4" r0-9053,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r2C-2Ds902C,"%~2\%~3\iot_app.X.production.bin.signature.hex" r905A-FFFFFFFF,"%~2\%~3\%~4" r0-9057,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r2E-2Fs902E,"%~2\%~3\iot_app.X.production.bin.signature.hex" r905E-FFFFFFFF,"%~2\%~3\%~4" r0-905B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r30-31s9030,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9062-FFFFFFFF,"%~2\%~3\%~4" r0-905F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r32-33s9032,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9066-FFFFFFFF,"%~2\%~3\%~4" r0-9063,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r34-35s9034,"%~2\%~3\iot_app.X.production.bin.signature.hex" r906A-FFFFFFFF,"%~2\%~3\%~4" r0-9067,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r36-37s9036,"%~2\%~3\iot_app.X.production.bin.signature.hex" r906E-FFFFFFFF,"%~2\%~3\%~4" r0-906B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r38-39s9038,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9072-FFFFFFFF,"%~2\%~3\%~4" r0-906F,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r3A-3Bs903A,"%~2\%~3\iot_app.X.production.bin.signature.hex" r9076-FFFFFFFF,"%~2\%~3\%~4" r0-9073,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r3C-3Ds903C,"%~2\%~3\iot_app.X.production.bin.signature.hex" r907A-FFFFFFFF,"%~2\%~3\%~4" r0-9077,"%~2\%~3\%~4" -O"%~2\%~3\%~4"
hexmate r3E-3Fs903E,"%~2\%~3\iot_app.X.production.bin.signature.hex" r907E-FFFFFFFF,"%~2\%~3\%~4" r0-907B,"%~2\%~3\%~4" -O"%~2\%~3\%~4"

del "%~2\%~3\temp_original_copy.X.production.hex"