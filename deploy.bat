@ECHO OFF
SET /P branchName=Please Enter The Branch Name Without /:
IF %branchName% == [] 0 GOTO E_INVALIDINPUT

@ECHO "copying file lambda_function.py"
XCOPY /y "D:\github\ohne\lambdas\ohne-lambda-etl\lambda_function.py" "D:\github\ohne\lambdas\ohne-lambda-etl\virtualenv\Lib\site-packages"

@ECHO "copying folder \app"
XCOPY /y /s /i "D:\github\ohne\lambdas\ohne-lambda-etl\app\*" "D:\github\ohne\lambdas\ohne-lambda-etl\virtualenv\Lib\site-packages\app"

@ECHO "generating %branchName% file"
powershell.exe -nologo -noprofile -command "& { Get-ChildItem -Path 'D:\github\ohne\lambdas\ohne-lambda-etl\virtualenv\Lib\site-packages' | Compress-Archive -DestinationPath 'D:\github\ohne\lambdas\ohne-lambda-etl\function-%branchName%.zip' -Force}"

@ECHO "deploying to aws lambda - fat-loans"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-fat-loans --zip-file fileb://function-%branchName%.zip  
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-fat-loans --description %branchName%

@ECHO "deploying to aws lambda - fat-loan-installments"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-fat-loan-installments --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-fat-loan-installments --description %branchName%

@ECHO "deploying to aws lambda - dim-contracts"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-contracts --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-contracts --description %branchName%

@ECHO "deploying to aws lambda - dim-loan-dates"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-dates --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-dates --description %branchName%

@ECHO "deploying to aws lambda - dim-loan-expiration-days"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-expiration-days --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-expiration-days --description %branchName%


@ECHO "deploying to aws lambda - dim-loan-installments-dates"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-installments-dates --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-installments-dates --description %branchName%

@ECHO "deploying to aws lambda - dim-loan-installments-statuses"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-installments-statuses --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-installments-statuses --description %branchName%

@ECHO "deploying to aws lambda - dim-loan-reasons"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-reasons --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-reasons --description %branchName%

@ECHO "deploying to aws lambda - dim-loan-statuses"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-statuses --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-statuses --description %branchName%

@ECHO "deploying to aws lambda - dim-users"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-users --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-users --description %branchName%

@ECHO "deploying to aws lambda - dim-bank-accounts"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-bank-accounts --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-bank-accounts --description %branchName%

@ECHO "deploying to aws lambda - dim-user-addresses"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-user-addresses --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-user-addresses --description %branchName%

@ECHO "deploying to aws lambda - dim-score-checks"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-score-checks --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-score-checks --description %branchName%

@ECHO "deploying to aws lambda - dim-loan-tags"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-loan-tags --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-loan-tags --description %branchName%

@ECHO "deploying to aws lambda - fat-loan-installments-aggregated"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-fat-loan-installments-aggregated --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-fat-loan-installments-aggregated --description %branchName%

@ECHO "deploying to aws lambda - fat-loan-charges"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-fat-loan-charges --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-fat-loan-charges --description %branchName%

@ECHO "deploying to aws lambda - dim-last-score"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-last-score --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-last-score --description %branchName%

@ECHO "deploying to aws lambda - dim-user-rg-documents"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-user-rg-documents --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-user-rg-documents --description %branchName%

@ECHO "deploying to aws lambda - dim-phones"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-phones --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-phones --description %branchName%

@ECHO "deploying to aws lambda - dim-user-personal-infos"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-user-personal-infos --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-user-personal-infos --description %branchName%

@ECHO "deploying to aws lambda - dim-personal-references"
powershell.exe aws lambda update-function-code --function-name ohne-lambda-etl-dim-personal-references --zip-file fileb://function-%branchName%.zip
powershell.exe aws lambda publish-version --function-name ohne-lambda-etl-dim-personal-references --description %branchName%

@ECHO "delete zip file"
DEL "D:\github\ohne\lambdas\ohne-lambda-etl\function-%branchName%.zip"

:E_INVALIDINPUT