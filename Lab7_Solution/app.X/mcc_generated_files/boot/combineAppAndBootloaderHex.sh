pwd
ls ../../../
ls ../../../boot.X
ls ../../../boot.X/dist
ls ../../../boot.X/dist/default/production
ls ../../../app.X
hexmate r0-3FFF,../../../boot.X/dist/default/production/boot.X.production.hex r4000-2AFFF,../../dist/default/production/app.X.production.hex r2B000-FFFFFFFF,../../../boot.X/dist/default/production/boot.X.production.hex -O../../dist/default/production/combined.production.hex
pwd
