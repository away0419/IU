package com.it.lylj.scFolder.model;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ScFolderServiceImpl implements ScFolderService{
    private final ScFolderDAO dao;

    @Override
    public int insertScFolder(ScFolderVO vo) {
        return dao.insertScFolder(vo);
    }

    @Override
    public List<ScFolderVO> selectAllScFolderByEmpNo(int empNo) {
        return dao.selectAllScFolderByEmpNo(empNo);
    }

	@Override
	public ScFolderVO selectScFolderByScFolderNo(int scheduleFolderNo) {
		return dao.selectScFolderByScFolderNo(scheduleFolderNo);
	}


    
    
}