from collections import defaultdict

sheng_mu_single = "bpmfdtnlgkhjqxrzcsyw"
sheng_mu = {k: k for k in sheng_mu_single}
sheng_mu.update(
    {
        "zh": "v",
        "ch": "i",
        "sh": "u",
    }
)

yun_mu_rev = {
    "b": ["ou"],
    "c": ["iao"],
    "d": ["iang", "uang"],
    "f": ["en"],
    "g": ["eng", "ng"],
    "h": ["ang"],
    "j": ["an"],
    "k": ["ao"],
    "l": ["ai"],
    "m": ["ian"],
    "n": ["in"],
    "o": ["uo"],
    "p": ["un"],
    "q": ["iu"],
    "r": ["er", "uan"],
    "s": ["ong", "iong"],
    "t": ["ue", "ve"],
    "v": ["ui"],
    "w": ["ia", "ua"],
    "x": ["ie"],
    "y": ["ing", "uai"],
    "z": ["ei"],
}
yun_mu_single = "aeiouv"
yun_mu = {k: k for k in yun_mu_single}
for k, v in yun_mu_rev.items():
    for vi in v:
        yun_mu[vi] = k

# 构造全拼表
full2double = {}
for k1, v1 in sheng_mu.items():
    for k2, v2 in yun_mu.items():
        full2double[k1 + k2] = v1 + v2
for k in yun_mu_single:
    full2double[k] = k * 2
# 将韵母中只有两个字母的作为单个全拼放入
for k in yun_mu.keys():
    if len(k) == 2:
        full2double[k] = k
# 加入特殊的拼音
full2double.update({"ang": "oh", "eng": "og"})


fullpin_repo = "./搜狗词库备份_2024_5_20.txt"
write_fn = "./my_double_pin_repo.txt"

# 1. 将重复的全拼放在一起
fullpins = defaultdict(list)
with open(fullpin_repo, "r", encoding="utf-8") as f:
    lines = f.readlines()
    for line in lines:
        fullpin, str_zh = line.strip().strip("'").split(" ")
        fullpins[fullpin].append(str_zh)

# 2. 将全拼换成双拼
doublepins = defaultdict(list)
for pins, str_zh in fullpins.items():
    words = pins.split("'")
    d_pin = []
    for word in words:
        if len(word) == 1 and len(words) > 1:
            d_pin.append(word)
        else:
            d_pin.append(full2double[word])
    d_pin = "".join(d_pin)
    doublepins[d_pin].extend(str_zh)
    # if pins == "de":
    #     print(d_pin)
    #     print(str_zh)

# 3. 储存为txt文件
with open(write_fn, "w", encoding="utf-8") as f:
    f.writelines(f"{k} {' '.join(v)}\n" for k, v in doublepins.items())
