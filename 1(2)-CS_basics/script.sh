
# anaconda(또는 miniconda)가 존재하지 않을 경우 설치해주세요!
## TODO


# Conda 환셩 생성 및 활성화
## TODO
set -e
source "$(conda info --base)/etc/profile.d/conda.sh"

conda activate myenv || conda create -n myenv -y
conda activate myenv
conda install -y python

## 건드리지 마세요! ##
python_env=$(python -c "import sys; print(sys.prefix)")
if [[ "$python_env" == *"/envs/myenv"* ]]; then
    echo "[INFO] 가상환경 활성화: 성공"
else
    echo "[INFO] 가상환경 활성화: 실패"
    exit 1 
fi

# 필요한 패키지 설치
## TODO
python -m pip install --upgrade pip
python -m pip install mypy

# Submission 폴더 파일 실행
cd submission || { echo "[INFO] submission 디렉토리로 이동 실패"; exit 1; }

for file in *.py; do
    ## TODO
    base="${file##*_}"
    base="${base%.py}"
    python "$file" < "../input/${base}_input" > "../output/${base}_output"
    echo "[INFO] 실행 완료: $file -> ../output/${base}_output"
done

# mypy 테스트 실행 및 mypy_log.txt 저장
## TODO
mypy .. > ../mypy_log.txt 2>&1

# conda.yml 파일 생성
## TODO
conda env export -n myenv > ../conda.yml


# 가상환경 비활성화
## TODO
conda deactivate
