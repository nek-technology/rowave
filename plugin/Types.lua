local types = {}

-- Plugin Level
export type ScriptSource = {
    Source: string,
    Lines: table,
    Classes: table,
    Functions: table,
    Properties: table,
    Types: table,
    Interfaces: table,
}

-- Source Level
export type Class = {
    Name: string,
    Description: string,
    Properties: table,
    Functions: table,
    StartLine: number,
    EndLine: number,
}

export type Function = {
    Class: Class,
    Name: string,
    Description: string?,
    Method: boolean?,
    Yielding: boolean?,
    Errors: table,
    Params: table,
    Return: Tag?,
    StartLine: number,
    EndLine: number,
}

export type Property = {
    Class: Class,
    Name: string,
    Description: string?,
    Line: number,
}

export type Type = {
    Class: Class,
    Name: string,
    Description: string?,
    Params: table,
    StartLine: number,
    EndLine: number,
}

export type Interface = {
    Class: Class,
    Name: string,
    Description: string?,
    TableContents: table,
    StartLine: number,
    EndLine: number,
}

-- Type Level
export type Tag = {
    Name: string,
    Value: string?,
    Descripton: string?,
}

export type MoonwaveComment = {
    -- Doc Comments
    Class: Class?,
    Within: string?,
    Prop: string?,
    Type: string?,
    Interfce: string?,
    Function: string?,

    -- The Tag tag
    Tag: Tag?,

    -- Function tags
    Yields: boolean?,
    Params: table,
    Return: Tag?,
    Errors: table,

    -- Usage tags
    Unreleased: boolean?,
    Since: Tag?,
    Deprecated: boolean?,

    -- Realm tags
    Server: boolean?,
    Client: boolean?,
    Plugin: boolean?,

    -- Visibility tags
    Private: boolean?,
    Ignore: boolean?,

    -- Interface tags
    Fields: table,

    -- Property tags
    ReadOnly: boolean?,

    -- Class tags
    __index: boolean?,

    -- General tags
    Description: string?,
    StartLine: number,
    EndLine: number,
}

return types