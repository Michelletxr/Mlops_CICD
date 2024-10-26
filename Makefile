install:
	pip install --upgrade pip && \
		pip install -r requirements.txt
	# Instale o pywin32 somente se estiver no Windows
	if [ "$$(uname)" = "MINGW32_NT" ] || [ "$$(uname)" = "MINGW64_NT" ]; then \
		pip install pywin32==308; \
	fi

format:	
	black *.py 

train:
	python train.py

eval:
	echo "## Model Metrics" > report.md
	cat ./Results/metrics.txt >> report.md
	
	echo '\n## Confusion Matrix Plot' >> report.md
	echo '![Confusion Matrix](./Results/model_results.png)' >> report.md
	
	cml comment create report.md
		
update-branch:
	git config --global user.name $(USER_NAME)
	git config --global user.email $(USER_EMAIL)
	git commit -am "Update with new results"
	git push --force origin HEAD:update

