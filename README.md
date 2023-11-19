### 1. Installation
```
wget -O - https://raw.githubusercontent.com/grassjelly/eztmux/main/install.bash | bash
```

### 2. Usage
2.1 Arbitrary number of panes
```
TOTAL_PANES=5
eztmux $TOTAL_PANES
```
2.2 Load profile
```
eztmux my_profile
```

2.3 Load existing profile
```
eztmux $PWD/my_profile.yaml
```
