if [ "$5" = "true" ]; then
exit 0
fi
hexmate r0-3FFF,"$2/$3/$4" r4008-FFFFFFFF,"$2/$3/$4" -O"$2/$3/temp_original_copy.X.production.hex" -FILL=w1:0x00,0x00,0x00,0x00@0x4000:0x4007
hexmate r4000-FFFFFFFF,"$2/$3/temp_original_copy.X.production.hex" -O"$2/$3/temp_crc.X.production.hex" -FILL=w1:0xFF,0xFF,0xFF,0x00@0x4000:0x2AFFF +-CK=4000-2AFFF@4000w-4g5p814141AB
hexmate r4000-4001,"$2/$3/temp_crc.X.production.hex" r4002-FFFFFFFF,"$2/$3/$4" r0-3FFF,"$2/$3/$4" -O"$2/$3/$4"
hexmate r4000-FFFFFFFF,"$2/$3/temp_original_copy.X.production.hex" -O"$2/$3/temp_crc.X.production.hex" -FILL=w1:0xFF,0xFF,0xFF,0x00@0x4000:0x2AFFF +-CK=4000-2AFFF@4002w-4g5p814141AB
hexmate r4004-4005,"$2/$3/temp_crc.X.production.hex" r4006-FFFFFFFF,"$2/$3/$4" r0-4003,"$2/$3/$4" -O"$2/$3/$4"
rm "$2/$3/temp_original_copy.X.production.hex"
rm "$2/$3/temp_crc.X.production.hex"