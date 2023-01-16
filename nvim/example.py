import pandas as pd
import torch


def main():
    print("Hello World")
    df = pd.read_csv("./xxx.csv", index_col=0)
    print(df.sample())
    torch.randint()



if __name__ == "__main__":
    main()
