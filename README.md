# asr-test-mic

## 程式碼來源:https://github.com/TensorSpeech/TensorFlowASR

## 環境

1. docker

    請注意路徑問題
    ```bash
    cd docker/
    ./build-dokcer-image.bash
    ./run-docker-container.bash
    ```
1. 另外安裝
    
    TensorFlowASR
    ```bash
    pip3 install -U "TensorFlowASR[tf2.3]"
    ```
    
    tensorflow_io
    ```bash
    pip install tensorflow-io==0.15
    ```
    
## Conformer

1. 訓練
    TensorFlowASR
    ```bash
    cd TensorFlowASR/examples/conformer/
    ```
    ```bash
    python train.py --config [The file path of model configuration file] --bs [Batch size per replica] --pretrained [Path to pretrained model] --devices [Devices' ids to apply distributed training]
    ```
1. 測試
    ```bash
    python test.py --config [The file path of model configuration file] --bs [Test batch size]  --saved [Path to saved model] --output [Result filepath]
    ```
