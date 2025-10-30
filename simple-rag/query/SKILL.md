---
name: simple-rag
description: "Documentation query and retrieval system using MCP Server with Weaviate vector database for semantic and keyword search across knowledge bases"
license: MIT
---

## Overview

The Simple-RAG plugin provides intelligent document retrieval and search capabilities through an MCP (Model Context Protocol) server. It connects to a Weaviate vector database to enable hybrid search combining semantic and keyword-based search across your knowledge base.

## Features

### 🔍 Hybrid Search
- **Semantic Search**: Find documents based on meaning and context
- **Keyword Search**: Traditional text-based matching
- **Combined Results**: Merges both approaches for optimal relevance

### 🎯 Advanced Filtering
- Filter by project names
- Filter by authors
- Filter by date range
- Filter by title content
- Multiple filter combinations

### 📊 Document Management
- List all documents with flexible filters
- Get chunk counts per project
- Analyze document distribution across projects

## Available Tools

### retrieve
Search for relevant document chunks using hybrid search.

**Parameters:**
- `query` (required): Search query string
- `projects`: Array of project names to filter by (optional)

**Example:**
```json
{
  "query": "How to configure authentication",
  "projects": ["project-a", "project-b"]
}
```

### retrieve_with_filters
Advanced search with multiple filter options.

**Parameters:**
- `query` (required): Search query string
- `projects`: Array of project names to filter by (optional)
- `dayAgo`: Number of days to look back (optional)
- `byAuthors`: Array of author names to filter by (optional)
- `titleNotContain`: Text that should NOT be in the title (optional)

**Example:**
```json
{
  "query": "API documentation",
  "projects": ["backend"],
  "dayAgo": 30,
  "byAuthors": ["john.doe"],
  "titleNotContain": "deprecated"
}
```

### list_documents
List documents with filtering options (no search query).

**Parameters:**
- `projects`: Array of project names to filter by (optional)
- `dayAgo`: Number of days to look back (optional)
- `byAuthors`: Array of author names to filter by (optional)

**Example:**
```json
{
  "projects": ["frontend"],
  "dayAgo": 7
}
```

### get_chunk_count_per_project
Get the total number of document chunks indexed per project.

**Parameters:**
- None required

**Example:**
```json
{}
```

## Use Cases

### Technical Documentation Search
Find relevant documentation across your entire knowledge base:
- Search for specific error messages
- Find configuration examples
- Locate API references
- Discover implementation patterns

### Project-Specific Research
Narrow down searches to specific projects or teams:
- Filter by team/projects
- Find recent updates
- Search by specific authors
- Exclude outdated content

### Knowledge Base Analysis
Understand your documentation landscape:
- See how documents are distributed
- Identify heavily documented areas
- Find gaps in documentation
- Track content across projects

## Technical Details

### Backend Components
- **MCP Server**: Handles protocol communication and tool execution
- **Weaviate**: Vector database for semantic search
- **Hybrid Search**: Combines dense vectors with sparse BM25

### Integration
This plugin connects to an MCP server that provides the following capabilities:
- Standards-compliant MCP protocol implementation
- Vector similarity search using embeddings
- Keyword-based search
- Result ranking and merging

## Requirements

- Active MCP server running at `/mnt/c/Users/Administrator/workspace/simplerag/mcp-server/`
- Weaviate vector database instance
- Indexed document chunks in the knowledge base

## Configuration

The plugin is configured via `.claude-plugin/.mcp.json`:
```json
{
  "mcpServers": {
    "simple-rag": {
      "command": "npm",
      "args": ["run", "dev"],
      "cwd": "/mnt/c/Users/Administrator/workspace/simplerag/mcp-server/"
    }
  }
}
```

## Notes

- Results are returned in JSON format
- Search is case-insensitive
- Semantic search requires embedding generation
- Filter combinations are supported
- Empty filters return all results
