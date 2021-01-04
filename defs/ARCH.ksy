meta:
  id: ARCH
  file-extension: archive
  endian: le
  encoding: ascii
seq:
  - id: magic
    contents: "ARCH"
  - id: unk
    type: u4
  - id: f_cnt
    type: u4
  - id: names_cnt
    type: u4
  - id: offset
    type: s8
instances:
  metadata:
    pos: offset
    type: metas
types:
  metas:
    seq:
      - id: names
        type: name_str
        repeat: expr
        repeat-expr: _parent.names_cnt
      - id: files
        type: f_desc
        repeat: expr
        repeat-expr: _parent.f_cnt
  name_str:
    seq:
      - id: len
        type: u4
      - id: str
        type: str
        size: len
      - id: pad
        contents: [0x0]
  f_desc:
    seq:
      - id: tstamp
        type: u8
      - id: hash
        size: 16
      - id: name
        type: name_str
      - id: chunks_cnt
        type: u4
      - id: chuncks
        type: chunk
        repeat: expr
        repeat-expr: chunks_cnt
  chunk:
    seq:
      - id: zeros
        size: 12
      - id: offset
        type: u8
      - id: size
        type: u8
