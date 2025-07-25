date ; hostname ; pwd
ADDR_1=node-0
PORT_1=19800

MASTER_ADDR=$ADDR_1
MASTER_PORT=$PORT_1
# NODE_RANK=$1 # input each node's rank
NODE_RANK=0

EXP_GPUS=1
# EXP_NODES=$2
EXP_NODES=1
EXP_IS=576
EXP_PGB=4 # larger if you can
EXP_PGEB=16 # 4 x EXP_PGB is okay
EXP_LR=9e-6
EXP_BS=504
EXP_ME=10
EXP_WS=0.1
EXP_WD=0.06
EXP_LMH=50
EXP_LMC=5
EXP_THL=2
EXP_HHS=2
EXP_RGM=albef_randaug_wohf
EXP_LP=ManagerTower_ftfpt_base_vqav2.ckpt

# export MASTER_ADDR=$MASTER_ADDR
# export MASTER_PORT=$MASTER_PORT
export NODE_RANK=$NODE_RANK

PREFIX_NAME="ftfpt-base-vqa"

echo $MASTER_ADDR, $MASTER_PORT, $NODE_RANK, $EXP_NODES, $EXP_IS, $EXP_PGB, $EXP_PGEB, $EXP_LR, $EXP_BS, $EXP_ME, $EXP_WS, $EXP_WD, $EXP_LMH, $EXP_LMC, $EXP_THL, $EXP_HHS, $EXP_RGM

TIME=$(date "+%Y%m%d%H%M")
RUN_NAME=""$PREFIX_NAME"-"$EXP_IS"-"$EXP_PGB"-"$EXP_PGEB"-"$EXP_RGM"-"$EXP_LR"-"$EXP_BS"-"$EXP_ME"-"$EXP_WS"-"$EXP_WD"-"$EXP_HHS"-"$TIME""

echo $RUN_NAME
python run.py with run_name=$RUN_NAME task_finetune_vqa_clip_bert mt clip16 text_roberta $EXP_RGM num_gpus=$EXP_GPUS num_nodes=$EXP_NODES root_path=$HOME/MT load_path=$HOME/MT/best_checkpoints/$EXP_LP image_size=$EXP_IS per_gpu_batchsize=$EXP_PGB per_gpu_eval_batchsize=$EXP_PGEB learning_rate=$EXP_LR batch_size=$EXP_BS max_epoch=$EXP_ME warmup_steps=$EXP_WS weight_decay=$EXP_WD lr_mult_head=$EXP_LMH lr_mult_cross_modal=$EXP_LMC task_head_layers=$EXP_THL head_hidden_scale=$EXP_HHS

date