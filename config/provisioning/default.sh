#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh

# Packages are installed after nodes so we can fix them...

#DEFAULT_WORKFLOW="https://..."

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/IbarakiDouji/WAI-NSFW-illustrious-SDXL/resolve/main/waiNSFWIllustrious_v150.safetensors?download=true"
    "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/HighNoise/Wan2.2-I2V-A14B-HighNoise-Q6_K.gguf?download=true"
    "https://huggingface.co/QuantStack/Wan2.2-I2V-A14B-GGUF/resolve/main/LowNoise/Wan2.2-I2V-A14B-LowNoise-Q6_K.gguf?download=true"
    
)



UNET_MODELS=(
    "https://huggingface.co/AliceThirty/Dasiwa-WAN2.2-I2V-14B-tastysin-V8.1-gguf/resolve/main/high/Q5_K_S/DasiwaWAN22I2V14BV8V1_tastysinHighV81-Q5_K_S.gguf?download=true"
    "https://huggingface.co/AliceThirty/Dasiwa-WAN2.2-I2V-14B-tastysin-V8.1-gguf/resolve/main/low/Q5_K_S/DasiwaWAN22I2V14BV8V1_tastysinLowV81-Q5_K_S.gguf?download=true"

)

TEXT_ENCODERS=(
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors"
)

CLIP_VISION=(
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"
)

SAMS=(
    "https://huggingface.co/1038lab/sam/resolve/main/sam_vit_b.safetensors?download=true"
)

LORA_MODELS=(
    "https://huggingface.co/bithge/sagittal/resolve/main/Alternate_ILV3.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/Haevelyn.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/guro_bisection_sagittal_ill_v2-35-04.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/guro_bisection_sagittal_ill_v2-30-04.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/bhdsx-v2IL.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/Poiseoned_Convulsion.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/Bowel_incontinence.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/Corpse.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/impefg-v2IL.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/stabby_toy_sword_V2.1-000019.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/neckstump_v1.safetensors?download=true"
    "https://huggingface.co/bithge/sagittal/resolve/main/mingsanta.safetensors?download=true"
    
    
)

VAE_MODELS=(
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
    
    
)

UPSCALE_MODELS=(
    "https://huggingface.co/Kim2091/AnimeSharpV3/resolve/main/2x-AnimeSharpV3.safetensors"
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    "https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
  
)

CONTROLNET_MODELS=(
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors"
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_mid.safetensors?download"
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/t2i-adapter_diffusers_xl_openpose.safetensors"
   
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui

    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    # (상단에 WORKSPACE 기본값도 같이 추천)
    export WORKSPACE="${WORKSPACE:-/workspace}"
    COMFYUI_DIR="/workspace/ComfyUI"
    COMFY_MODELS_DIR="${COMFYUI_DIR}/models"
    
    provisioning_get_models "${COMFY_MODELS_DIR}/checkpoints"    "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/unet"           "${UNET_MODELS[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/loras"          "${LORA_MODELS[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/controlnet"     "${CONTROLNET_MODELS[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/vae"            "${VAE_MODELS[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/upscale_models" "${UPSCALE_MODELS[@]}"
    
    # ✅ 네 스크립트에 “선언만” 돼 있던 것들도 실제로 받게 추가
    provisioning_get_models "${COMFY_MODELS_DIR}/text_encoders"  "${TEXT_ENCODERS[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/clip_vision"    "${CLIP_VISION[@]}"
    provisioning_get_models "${COMFY_MODELS_DIR}/sams"           "${SAMS[@]}"

    provisioning_print_end

}

function pip_install() {
    if [[ -z $MAMBA_BASE ]]; then
            "$COMFYUI_VENV_PIP" install --no-cache-dir "$@"
        else
            micromamba run -n comfyui pip install --no-cache-dir "$@"
        fi
}

function provisioning_get_apt_packages() {
    if (( ${#APT_PACKAGES[@]} > 0 )); then
        sudo $APT_INSTALL "${APT_PACKAGES[@]}"
    fi
}

function provisioning_get_pip_packages() {
    if (( ${#PIP_PACKAGES[@]} > 0 )); then
        pip_install "${PIP_PACKAGES[@]}"
    fi
}


function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"

        mkdir -p "${COMFYUI_DIR}/custom_nodes"

        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                [[ -e $requirements ]] && pip_install -r "$requirements"
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            [[ -e $requirements ]] && pip_install -r "$requirements"
        fi
    done
}


function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > /opt/ComfyUI/web/scripts/defaultGraph.js
        fi
    fi
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    local url="$1"
    local outdir="$2"
    local dotbytes="${3:-4M}"
    local auth_token=""

    if [[ -n "$HF_TOKEN" && $url =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif [[ -n "$CIVITAI_TOKEN" && $url =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi

    if [[ -n "$auth_token" ]]; then
        wget --header="Authorization: Bearer $auth_token" -nc --content-disposition --show-progress -e dotbytes="$dotbytes" -P "$outdir" "$url"
    else
        wget -nc --content-disposition --show-progress -e dotbytes="$dotbytes" -P "$outdir" "$url"
    fi
}


provisioning_start
